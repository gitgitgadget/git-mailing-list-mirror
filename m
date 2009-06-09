From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git merge selective files
Date: Tue, 9 Jun 2009 15:39:31 -0400
Message-ID: <32541b130906091239x1c92a1caxd260983a66e8025f@mail.gmail.com>
References: <34b359190906090253v653ecc71q6684f4ebff2be59d@mail.gmail.com> 
	<32541b130906091132sc5a647cn5fe0289ff9793cc3@mail.gmail.com> 
	<4A2EB575.8050107@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: joe higton <draxil@gmail.com>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME7Ay-0007yZ-KE
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757807AbZFITjw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756983AbZFITjw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:39:52 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:58451 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbZFITjv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 15:39:51 -0400
Received: by gxk10 with SMTP id 10so280937gxk.13
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=08cpxKrzIAGKyw7QRvQ4tpXFVfOStm3AqucAbsft0fU=;
        b=PDK8I8Z9TCYBhfEEixwQdTwmCN+EiGPwqYXf6/8bR8UxzavLGPA0T8D3/UrjBKETZO
         y49tpg9EaMr+qMYHvBwdB7HFepmuPCvZtDcOQwZiX8yemvlxDMfJKrtY39KvawnXTEag
         gLa5WtkIJ3+UwOtsFKmUNwI0yd6DYQw7o/T/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FPBzjty3/J7D3FvUxRMe3FHvzX/fnLPZ7YEgOyxddfgnW6C0p928kA/IwtWliQAjWm
         kGEexwa7q+ZPRU0a1tsrMNP+spvkkURXZBb46B7pTHED2WfUgpujyvGNKhfA3QgwUm0x
         pE1quY0Ljpu2K7tu9npixCkVmynhwpUK/1C6g=
Received: by 10.151.68.2 with SMTP id v2mr1067998ybk.30.1244576391178; Tue, 09 
	Jun 2009 12:39:51 -0700 (PDT)
In-Reply-To: <4A2EB575.8050107@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121213>

On Tue, Jun 9, 2009 at 3:18 PM, Joshua Jensen<jjensen@workspacewhiz.com=
> wrote:
> On Tue, Jun 9, 2009 at 5:53 AM, joe higton<draxil@gmail.com> wrote:
>> =A0 =A0 I want to merge changes from a branch but only to one file, =
I
>> don't want to pick up the changes from other files. I've scoured
>> google and the docs a bit but I can't find anything useful. Is this
>> possible?
>
> I like this one:
>
> http://jasonrudolph.com/blog/2009/02/25/git-tip-how-to-merge-specific=
-files-from-another-branch/

Careful... that *replaces* the files with the ones from the branch.
It doesn't *merge* them.  Although that may be exactly what you want.

And the "'merge --squash' and don't commit the changes you don't want"
option looks okay to me too.

Avery
