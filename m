From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: "add -p" + filenames with UTF-8 multibyte characters = "No  changes"
Date: Sun, 15 Feb 2009 21:11:00 +0200
Message-ID: <87prhjqzwb.fsf@iki.fi>
References: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com>
	<87tz6vr0g4.fsf@iki.fi>
	<2b8265360902151100n2eca0182odf9543c1dd8a7f98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Antonio =?iso-8859-1?Q?Garc=EDa_Dom=EDnguez?= 
	<nyoescape@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:12:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmPq-0007la-82
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbZBOTLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 14:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbZBOTLE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:11:04 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:54148 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbZBOTLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:11:03 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48FC5AC9051C939F; Sun, 15 Feb 2009 21:11:01 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LYmOK-0005el-H3; Sun, 15 Feb 2009 21:11:00 +0200
In-Reply-To: <2b8265360902151100n2eca0182odf9543c1dd8a7f98@mail.gmail.com>
 ("Antonio =?iso-8859-1?Q?Garc=EDa_Dom=EDnguez=22's?= message of "Sun\, 15
 Feb 2009 20\:00\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110033>

[Added the Git list back to delivery.]

On 2009-02-15 20:00 (+0100), Antonio Garc=EDa Dom=EDnguez wrote:

>> This bug is documented in BUGS section of "git add" manual (see "git
>> help add"). You can work it around with
>>
>>    git config --global core.quotepath false
>
> Oh, sorry, I should have known better and RTFM. :-D

No problem at all. I was bitten by the same bug earlier, and as I wasn'=
t
able to fix it I sent a documentation patch instead. :-)

"core.quotepath=3Dfalse" is good for other purposes too. It prints UTF-=
8
filenames in diff headers in form that is actually readable. I think it
would be better default.
