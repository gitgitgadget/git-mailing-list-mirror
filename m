From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Wed, 20 Apr 2016 08:56:55 +0100
Message-ID: <CAE5ih78Cj+-BrE3WrGF3Wo5Nr+8PwY+pgBWee5VzerzhytBMWg@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
	<CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
	<xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBx4vCUpYTGYM9VF6QHxGGgQSG5APSHymtbV7uVxAbU+ow@mail.gmail.com>
	<xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
	<CABEqOBzXvr3Xp+XJtqjL5eY8Spy8Bi1SezCut0_QJdYnw9C4Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:57:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asn0P-0006RG-LY
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 09:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbcDTH45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 03:56:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:32945 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcDTH44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 03:56:56 -0400
Received: by mail-ob0-f174.google.com with SMTP id tz8so27934056obc.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4WBYMUQkcK3CpnmZUnNdg+VHQVMRCp7q4Kdzyz/b7xw=;
        b=TgYwNyQK7dohx5FCWtfWB49c7cpWXBPTZYKWFTEqkbLN6uC+9OVJ3MDniK/cZbh4S5
         QrUnRS9cs6esTUkj0csyjf9GKFf5kSBXvc36Chdai25cK0xWgtYK1n05tCpdYqOYThU+
         DASqMPzkheEnGT/KKST9B8RO8FWvNQLE0vJTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4WBYMUQkcK3CpnmZUnNdg+VHQVMRCp7q4Kdzyz/b7xw=;
        b=VNaE80wUfHkuVzLZUKjhMdKzEkfwsDiHz3p7040h70i3BarnO8CY9HDZTpQebRzd4q
         IXQNRUb5aOfuIelLk20Ue1AUbKFKRQMoNVd0/FP+m7HLDiu3DPzoTdRrdb9h9K1rmBtf
         iVhgSjwkxnZrEUSXMoTkq4tG8mQOSmlSm7fGB1lW6oavhOwNod5TqZ3VWyX79Q1Z4HW/
         0sGF4tbBGfHRJBETnl2lzKEhFBvz5sL7LkrJtCeWbjiuYTakvLdjS5swZcdCJLw87Gqs
         IfhGsZkh1fIABLKhFmOWPqmufZS47tb1tqLEZfPpSF63dFUctIJj0UMZEgyHLtI5iYa7
         k0Pw==
X-Gm-Message-State: AOPr4FX4FTQx/D6jxO0CGNahlCII1T9DR4Za0ZPee0LdCSTzXrqLEah1IqbT2ORrr7Jw2+ncuM2hNLn7gAsHJA==
X-Received: by 10.60.177.9 with SMTP id cm9mr3229096oec.46.1461139016012; Wed,
 20 Apr 2016 00:56:56 -0700 (PDT)
Received: by 10.202.75.210 with HTTP; Wed, 20 Apr 2016 00:56:55 -0700 (PDT)
In-Reply-To: <CABEqOBzXvr3Xp+XJtqjL5eY8Spy8Bi1SezCut0_QJdYnw9C4Zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291989>

On 19 April 2016 at 22:44, Jan Durovec <jan.durovec@gmail.com> wrote:
>> By the way, you may or may not have noticed that I've been
>> reordering the lines of your message quoted in my responses; around
>> here, top-posting is frowned upon.
>
> I haven't noticed. Thanks for pointing out.
>
> As for the submitGit cover letter I wanted to raise at least an issue
> (if not create a fix itself) but it seems to be raised already as
> https://github.com/rtyley/submitgit/issues/9

To be honest, it would be just as easy to learn how to use git
format-patch and git send-email. It makes your head hurt a bit the
first few times you use it, but it's pretty straightforward.

And it also means that if there's a zombie apocalypse, and github gets
overrun, you can still exchange patches to your anti-virus and save
humanity from extinction.

Of course, if you don't care about the future of the human race, then
that's up to you.... :-)

Luke
