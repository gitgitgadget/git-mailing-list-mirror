From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: [egit-dev] Re: jgit problems for file paths with non-ASCII characters
Date: Thu, 26 Nov 2009 16:31:53 +0100
Message-ID: <4B0E9F69.9040502@syntevo.com>
References: <4B0D356D.1080709@syntevo.com> <200911252211.55137.robin.rosenberg@dewire.com> <20091126005423.GM11919@spearce.org> <4B0E7DF5.9040007@syntevo.com> <alpine.DEB.1.00.0911261546350.7500@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 26 16:31:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDgJM-0001mJ-1T
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 16:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbZKZPa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 10:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbZKZPa7
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 10:30:59 -0500
Received: from syntevo.com ([85.214.39.145]:48413 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690AbZKZPa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 10:30:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id E323637C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.0911261546350.7500@intel-tinevez-2-302>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133802>

> You mean we should do the same thing as Apple with HFS?  Are you serious?

Yes, I'm serious. IMHO there should be a defined clear encoding used for
files names in the repository. Otherwise you don't know what you can expect
by reading it - it could mean anything. File names are in fact strings which
are based on characters. To convert characters to bytes (or visa versa) you
need to know the encoding.

--
Best regards,
Thomas Singer
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com


Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 26 Nov 2009, Thomas Singer wrote:
> 
>> [someone said, Thomas did not say who]
>>
>>> But as you said, this still doesn't make the Apple normal form any 
>>> easier.  Though if we know we are on such a strange filesystem we 
>>> might be able to assume the paths in the repository are equally 
>>> damaged.  Or not.
>> Well, if the git-core folks could standardize on, e.g., composed UTF-8 
>> (rather then just UTF-8), for storing file names in the repository, then 
>> everything should be clear, isn't it?
> 
> You mean we should do the same thing as Apple with HFS?  Are you serious?
> 
> Ciao,
> Dscho
