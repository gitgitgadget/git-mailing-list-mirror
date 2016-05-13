From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: bug report
Date: Fri, 13 May 2016 12:40:39 +0530
Message-ID: <CAFZEwPMe2W2R2GghMnyQ4BLyvm00oHEweNSZYrqn+=9BhSazvw@mail.gmail.com>
References: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
	<CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
	<CABKuJ_QZHTRcPWbwv1FSXEijxOpXameo-JJuZREGyA5daLbKLQ@mail.gmail.com>
	<CAFZEwPP32vWrCA9H+JbFineodDtGx2_bTjGy-nZ9KW2v8bP5vQ@mail.gmail.com>
	<CABKuJ_SEK-t93sCmj6aFSAbk8muX_ocQx6ZQZV3ZrNmvVmvDQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 09:10:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b17FL-00042c-MR
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 09:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbcEMHKl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 03:10:41 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34885 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbcEMHKk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 03:10:40 -0400
Received: by mail-yw0-f181.google.com with SMTP id g133so95160343ywb.2
        for <git@vger.kernel.org>; Fri, 13 May 2016 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=BPDf7Ipk5qyXnfnv9Y1213or22L+RhNkYi3lIyP7H3Q=;
        b=DW8oq/meUuH9yXQ5LK0JwtTb6muTKnVt3wY00ayI/EQBI+8HB3Q26PISBbWgKkgwaA
         RNBPqsIgUyoGcvOO83emj1Q5yXsoH6Jytqdv9j5YWnaR1VDn0Z1050YCzM77//kPkP7z
         ZdaMh4fAOu8CWGUrOsJOwlLjkFZ8psHYNEbZS3iIn1xGnpQmO2SnDNlDGcIEOYSTjs4g
         h3OflG+4j7ggrsES+NcqC0XPhVQov2N+Bkv2oc9AHlXja9olCX5B3YRLP+1qvmIsNhPk
         7ZDuQGqPHKwCtBPGpeduZQC4jdqRzeV98nXg1bH+zmcj150Tj+Paw+cqzlgv57CgeZ4B
         iF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=BPDf7Ipk5qyXnfnv9Y1213or22L+RhNkYi3lIyP7H3Q=;
        b=Wztmzv0LKvV+9UNnIA6u08ALPr7Gcn3H8WW3tP6uocCtJrr4AScZKGtjvQmT2hgIsQ
         zotcuy01nhIUgGMgA+l+dDvLswxlswmTpYdlV70DHRS9h1fHcKDu7aT+VQ5XwcTHVsVn
         nKXlWhqOeDuY2cRYlLbfbT5MN4c1zxDQ7R80LDTSBbVRYioHhIJWwCqkMSREkzkhjt2S
         vRmcFB/GD10NJ7nr4S/0fwPHjtjhQ5fqV11I1bAZXqjkI1iCzL1WYOAvoDSI9LioNg8E
         9xJLKsr+qbtHzgksiJ6eopSi56kRoVKo7QmVGUJaFl9Y9GnGcbjeIUvR0/K+BtzNfj+8
         otrQ==
X-Gm-Message-State: AOPr4FWP1NzsSXJtHQ2SJXqR9cfcR26teNkmZFkCXOZ5YnN+RJN0kSw685lSg0v2dpsvQWofNlaXK7/IfN2ovw==
X-Received: by 10.37.118.69 with SMTP id r66mr6647939ybc.80.1463123439391;
 Fri, 13 May 2016 00:10:39 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Fri, 13 May 2016 00:10:39 -0700 (PDT)
In-Reply-To: <CABKuJ_SEK-t93sCmj6aFSAbk8muX_ocQx6ZQZV3ZrNmvVmvDQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294513>

On Fri, May 13, 2016 at 12:27 PM, =E6=9D=8E=E6=9C=AC=E8=B6=85 <libencha=
o@gmail.com> wrote:
> Yes, you got the right understanding of my problem.
>
> You are right, the git behavior is quite correct. But I met this
> problem in my practical work:
>
> My colleague added a method but I didn't know. I also added the same =
method.
> Then I found that I didn't need the method actually, so I deleted it.
> My colleague merged to the master before me. When I wanted to merge, =
I found
> conflicts with master. And I rebased to current master. And That meth=
od was
> deleted finally without any warning or information.

I am quite sure that there would be an output to show that there are
conflicts and it would be suggesting you to first resolve the
conflicts and there would also be markers in the file like ">>>>>" and
"=3D=3D=3D=3D=3D=3D" and the file would be marked with "both modified".=
 After you
resolve the conflicts, you can add the file by using git-add and then
"git rebase --continue" to proceed. If you find out that there is some
problem, then you can always use "git rebase --abort" to abort the
rebase process and get to the initial state *perfectly* without any
glitches.

> Do you think Git should output something to warn the user or I just
> use Git in a wrong way ?

It does warn. I don't know how it got missed in your case. This is
quite a common problem and even I have faced this quite for quite a
lot of times now and it always did warn me.

> Thanks.

I will recommend you reading this article[1]. I know its a bit of a
long read but it will help a lot.

[1]: http://tedfelix.com/software/git-conflict-resolution.html

Regards,
Pranit Bauva
