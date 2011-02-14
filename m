From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 16:17:19 +0200
Message-ID: <AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<87k4h34bhj.fsf@catnip.gol.com>
	<7vr5bbupj4.fsf@alter.siamese.dyndns.org>
	<AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
	<4D58D2DF.1050205@viscovery.net>
	<AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
	<4D5906FD.7030502@drmicha.warpmail.net>
	<AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
	<4D59316E.5090203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 15:17:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PozFB-0000Rj-3G
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 15:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093Ab1BNORW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 09:17:22 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56801 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab1BNORV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 09:17:21 -0500
Received: by fxm20 with SMTP id 20so5263166fxm.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YPzCvnnOp96Vqfs3JLA50f2Xcrc1ThxpivizDVpIxXc=;
        b=E2iEINRPyE88OJSBLmlDCYDIhsHtilXxMQiZuygNEBR5XBmzV2jg8+lrkTZ/MZt6yz
         rBXSILNa3EG2XqhrpT1W7EwseYEo+qBP6tbG0HTK7iIY7Vn2aKcPgBf9wTGfwwCZmWPa
         nx+XDCPg4LSrQKag14oezxpozgWgON0Em0cr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qwAJnTrYc9A2psy0Bwm1xIKQlxtPJAuriJtEy6X94nd0RzDiV3TBDuh+xcX2MDMOMR
         5AgH2hlh0WilFri46imth1IpP5vEPhYuMMe7CSTETxtdkePiC2ZQl0O5ud6JdvP9Cb7b
         iUFGqKEZCPRAHFnMJzle1FcJoocqYAVr9Ilho=
Received: by 10.223.73.202 with SMTP id r10mr4832436faj.133.1297693039930;
 Mon, 14 Feb 2011 06:17:19 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 14 Feb 2011 06:17:19 -0800 (PST)
In-Reply-To: <4D59316E.5090203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166714>

On Mon, Feb 14, 2011 at 3:43 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 14.02.2011 14:14:
>> On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Full disclaimer: I have an alias "staged" for "diff --cached" myself...
>>
>> Be careful with your fingers. There's a command named "git stage".
>
> I know. Can we remove it as part of 1.8.0? It's our only builtin alias.

I have proposed before to extend 'git stage', so you can do 'git stage
diff', or if you alias 'git stage' to 'git s', just 'git s diff'. This
would not conflict with the old behavior of 'git stage $file'.

case "$1" in
add)
        shift
        git add $@
        ;;
rm)
        shift
        git rm --cached $@
        ;;
diff)
        shift
        git diff --cached $@
        ;;
import)
        shift
        git ls-files --modified --others --exclude-standard -z $@ | \
        git update-index --add --remove -z --stdin
        ;;
ls)
        shift
        git ls-files --stage $@
        ;;
*)
        git add $@
        ;;
esac

Cheers.

-- 
Felipe Contreras
