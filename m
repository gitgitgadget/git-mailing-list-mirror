From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 1/3] gitk: refactor: separate generic hunk parsing out of
 find_hunk_blamespecs{}
Date: Tue, 24 Jun 2014 21:27:12 +0300
Message-ID: <20140624182712.GA31008@wheezy.local>
References: <20140203205352.GA5136@wheezy.local>
 <20140203223346.GA14202@wheezy.local>
 <20140203224152.GA14305@wheezy.local>
 <CAPig+cRv6851TWgRU6sBorKYZ0ABXv+a3oi=hrGjxYz9P6T7mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzVSu-0007PY-MZ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 20:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbaFXS3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 14:29:04 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:39536
	"EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752686AbaFXS3D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2014 14:29:03 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2014 14:29:03 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa09-02.prod.phx3.secureserver.net with 
	id JJTM1o00B3gsSd601JTW5k; Tue, 24 Jun 2014 11:27:36 -0700
Content-Disposition: inline
In-Reply-To: <CAPig+cRv6851TWgRU6sBorKYZ0ABXv+a3oi=hrGjxYz9P6T7mg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252416>

On Mon, Feb 03, 2014 at 06:20:36PM -0500, Eric Sunshine wrote:
> On Mon, Feb 3, 2014 at 5:41 PM, Max Kirillov <max@max630.net> wrote:
>> For requesting a region blame, it is necessary to parse a hunk and
>> find the region in the parent file corresponding to the selected region.
>> There is already hunk parsin functionality in the find_hunk_blamespec{},
> 
> s/parsin/parsing/
> s/in the/in/
> 
>> but returns only information for a single line.
> 
> s/but/but it/
>

Thank you!

-- 
Max
