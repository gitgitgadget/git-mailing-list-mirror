From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 0/2] Fix resolvable rename + D/F conflict testcases
Date: Wed, 8 Sep 2010 00:41:26 -0600
Message-ID: <AANLkTin0KidU3og7SVEVUAaRfMzafEvvme_vP-0V773E@mail.gmail.com>
References: <1283928041-9882-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 08:41:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtELg-0007DJ-Uq
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 08:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab0IHGl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 02:41:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab0IHGl1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 02:41:27 -0400
Received: by fxm16 with SMTP id 16so529506fxm.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uc1m7Okd87lrZ0WnDWusPG1pTT3dF/q9+S0T/YrsqI8=;
        b=t8TQYpdwXkVUHvQkfFBfcqM6etVenY4a+bs6hOwQ5uE5TQonvaM3rKn0HinOwA6Vm4
         jpPe/UjyQPt7IUJQSAAHQLEptwz1dCGdCxgCkIWZBfTVFbRaWfYABqb/DlUHm1yH3p1c
         gKMmNmawqUsSxyORKZtoTVQudeSiIUFrgwYBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JjcL4EadtYSvyGp0Zrzf3UWgneiEN7NztZ/extx/MyAubn3gZ4WXvQoenKfmLhdc2f
         5A5I44kZLBEmvxnzDKn/2zv8NTQXN5OJlpx3KVWkrmlf3j4nLkTKf6SIybDQ8jG5jQ0V
         Gpi+D3eXCX5+xicuLj5zlJOS8hGeN9cSsbE7I=
Received: by 10.223.118.15 with SMTP id t15mr118786faq.96.1283928086673; Tue,
 07 Sep 2010 23:41:26 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 7 Sep 2010 23:41:26 -0700 (PDT)
In-Reply-To: <1283928041-9882-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155772>

On Wed, Sep 8, 2010 at 12:40 AM, Elijah Newren <newren@gmail.com> wrote=
:
> This fixes an issue reported by Nick (no lastname given) on the
> mailing list, as well as a closely related issue in the handling of
> rename + directory/file conflicts, namely where a filename on one sid=
e
> of the rename is a directory name on the other side of the merge.
>
> Change since v1:
> =C2=A0* Split unrelated 2/3 patch out into a separate submission

=2E..oh, and now the series is based on master instead of next.  (I
would base it on maint, but since I was adding another testcase to
t3509 and t3509 does not yet exist in maint, I couldn't as easily put
it there.)
