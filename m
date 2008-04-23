From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: git-gui hangs on read
Date: Wed, 23 Apr 2008 10:50:18 +0200
Message-ID: <480EF84A.4020308@isy.liu.se>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com> <20080422001311.GS29771@spearce.org> <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com> <20080422232530.GK29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Benjamin Collins <ben.collins@acm.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 11:09:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joayq-0004Nu-BA
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 11:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYDWJIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 05:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbYDWJIo
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 05:08:44 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:35336 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbYDWJIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 05:08:43 -0400
X-Greylist: delayed 1102 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Apr 2008 05:08:43 EDT
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id CD9AB259AC;
	Wed, 23 Apr 2008 10:50:19 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 09027-04; Wed, 23 Apr 2008 10:50:19 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 22DD62594F;
	Wed, 23 Apr 2008 10:50:19 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080422232530.GK29771@spearce.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80201>

On 04/23/2008 01:25 AM, Shawn O. Pearce wrote:
> Benjamin Collins <ben.collins@acm.org> wrote:
>> On Mon, Apr 21, 2008 at 7:13 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>>  From the strace it looks like your aspell is not giving us a
>>>  reply to the "$$cr master" command.  What does this give you?
>> $ aspell --mode=none --encoding=UTF-8 pipe <<EOF
>>> !
>>> $$cr master
>>> EOF
>> @(#) International Ispell Version 3.1.20 (but really Aspell 0.50.5)
>> & cr 70 5: Cr, cry, RC, CPR, CRT, Car, car, ctr, cur, CT, Ct, ct, C, R, c, r, Ce
>> , cir, Gr, Jr, Kr, gr, qr, NCR, OCR, VCR, CA, CO, Ca, Co, Cu, RR, ca, cc, ck, co
>> , cu, cw, yr, BR, Br, CB, CD, CF, CV, CZ, Cb, Cd, Cf, Cl, Cm, Cs, Dr, Fr, HR, Lr
>> , Mr, PR, Pr, Sr, Zr, cf, cg, cl, cm, cs, fr, hr, pr, tr
>>
> 
> Awww hell.  I think I see two issues.  The first is $$ maybe
> was expanded by your shell so aspell didn't see it as a command?
> I should have used <<'EOF' to avoid that, but I uh, forgot.
> 
> Can you upgrade aspell to 0.60.5?  Everywhere that I have used
> git-gui 0.10 that's the version I have had available.  I wonder
> if 0.50.5 has an issue here, or just doesn't support the "$$cr"
> command I was trying to use.  In which case I can try to make
> git-gui 0.10.2 detect the aspell version and avoid using $$cr
> if its an old version.
> 

Hi!

I just ran into the same/similar problem using the latest msysGit git 
version on Windows XP.

I have aspell 0.50.3 alpha installed on my laptop, and that seems to be 
basically up to date for the Windows port of aspell.  Is there any way 
to get around this problem?

/Gustaf
