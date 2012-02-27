From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug: post-receive-email sometimes misses commits
Date: Mon, 27 Feb 2012 21:43:02 +0100
Message-ID: <4F4BEAD6.9040109@alum.mit.edu>
References: <4F4BEA09.90600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 21:43:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S27Pd-0002A3-46
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 21:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab2B0UnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 15:43:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35625 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab2B0UnE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 15:43:04 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1RKh2Y3029257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Feb 2012 21:43:02 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
In-Reply-To: <4F4BEA09.90600@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191667>

On 02/27/2012 09:39 PM, Michael Haggerty wrote:
> [...]  It generates the
> "new" commits for A using the equivalent of
> 
>     git rev-list ^master ^B A
> 
> and it generates the "new" commits for B using the equivalent of
> 
>     git rev-list ^master ^B A

Sorry, that last line should of course be

    git rev-list ^master ^A B

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
