From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 23:03:22 +0100
Message-ID: <40aa078e1002021403x49920df9x3eca13207ce3e9f9@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:03:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQqH-0006ew-NU
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab0BBWDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 17:03:25 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50717 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab0BBWDY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 17:03:24 -0500
Received: by bwz19 with SMTP id 19so534029bwz.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/q6J3yaPwasWqz8qlBvlcH3n05kZidANCA9D3D+ZBOY=;
        b=k+ChjeVUth5sEbCcmKYDeiwwJG4JZ/GTMY7Wb6AdxGxb6AOM1T4dO6KEpqXH5AH1ja
         W/jTMzohXagsT95XgEib9W5UJrkAehLouaCgEnTu0iuYW5/kVpwwfdWq4sWPBbp6XuTw
         qCFwXgmanVqe4v7jFFbZ0bKazyCjUxBa2Z450=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=u2UGfPR4kNt8No3i5+4pKBQkZOG7yc1e//FI79fVCMJea+IaMFm4kqoUcy69R8bmbg
         Sbqpd0cryYsgG2fEtHzy1I5GGnNGHveZQJn3WHOF/tzSGQeXFsLVpZtXcP6Y/0ZcJqib
         ziFD5vL+BPtluYYL22kOHxqpxzeQ+XX2m4oAw=
Received: by 10.204.151.217 with SMTP id d25mr2173202bkw.24.1265148202560; 
	Tue, 02 Feb 2010 14:03:22 -0800 (PST)
In-Reply-To: <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138767>

On Tue, Feb 2, 2010 at 10:56 PM, Eugene Sajine <euguess@gmail.com> wrot=
e:
>>
>> As has already been pointed out, an extremely common workflow for "g=
it
>> commit --amend" is to include additional changes that were accidenta=
lly
>> overlooked =A0in the initial commit, and no changes are made to the =
commit
>> message.
>>
>> Changing the behavior would break that perfectly reasonable,
>> widely-practised workflow, and _that_ would be 100% not ok.
>
> I'm not against that workflow - I'm not forcing anybody to change the
> commit message. The thing I'm talking about is roughly that it should
> NOT treat the result of command ":q" the same way as the command
> ":wq".
>

Quite a lot of text-editors on prevents a user from saving when the
buffer is unchanged, so I don't think this would actually work. Keep
in mind that vi is not the only editor one can use to edit commit
messages.

--=20
Erik "kusma" Faye-Lund
