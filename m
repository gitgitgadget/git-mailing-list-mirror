From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Question about commit message wrapping
Date: Tue, 13 Dec 2011 04:14:36 +0100
Message-ID: <4EE6C31C.60909@alum.mit.edu>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <m3zkf1hnh9.fsf@localhost.localdomain> <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com> <201112102030.15504.jnareb@gmail.com> <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com> <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com> <4EE62DB9.8030406@ira.uka.de> <op.v6edibfz0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?B?U2lkbmV5IFNhbiBNYXJ0w61u?= <s@sidneysm.com>,
	git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 04:14:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaIpL-0001nR-7G
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 04:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab1LMDOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 22:14:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46064 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab1LMDOl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 22:14:41 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFA7.dip.t-dialin.net [84.190.223.167])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBD3EasM017559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Dec 2011 04:14:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <op.v6edibfz0aolir@keputer>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186998>

On 12/12/2011 11:16 PM, Frans Klaver wrote:
> Wrapped code as in auto-wrapped? Or as in manually wrapped? Python
> programmers have significant white space, but you can still hard wrap
> stuff, as long as the next statement is properly indented.

This is incorrect.  Python statements can only be broken across lines
within unbalanced parenthesis (or using '\' or within a multiline
string).  For example,

    x =
        1

is a syntax error, while

    y = (
        1
        )

or

    f(1,
          2,
      3,
      4)

are both valid.

FWIW I think automatic wrapping of commit messages is a bad idea.  I
wrap my commit messages deliberately to make them look the way I want
them to look.  The assumption of an 80-character display has historical
reasons, but it is also a relatively comfortable line-width to read
(even on wider displays).  And given that commit messages sometimes
contain "flowable" paragraph text, sometimes code snippets, sometimes
ASCII art, etc, no automatic wrapping will work correctly unless
everybody agrees that commit messages must be written in some specific
form of markup (or lightweight markup).  And I can't imagine such a
thing ever happening.

As for "future-proofing", do you really think there will be a lot of
programming happening on mobile phones with less than 80-character-wide
displays?  (And even my little HTC can easily fit 80 characters if I
rotate the phone to "landscape" mode.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
