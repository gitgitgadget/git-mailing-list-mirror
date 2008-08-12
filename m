From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: TOPGIT: [PATCH] tg create: add --force option to resolve merge dependencies.
Date: Tue, 12 Aug 2008 19:55:16 +0200
Message-ID: <36ca99e90808121055v5efcc1do68731b905a359a68@mail.gmail.com>
References: <1218546106.7264.11.camel@heerbeest>
	 <20080812133857.GL32184@machine.or.cz>
	 <1218553338.7264.14.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Jan Nieuwenhuizen" <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Aug 12 19:56:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSy6X-0006jv-3E
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 19:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbYHLRzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 13:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYHLRzS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 13:55:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:25536 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYHLRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 13:55:17 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1721491wxd.4
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CLYZsW+9hSdxvItn6M+pdbUUheiBpygdROFsevHurAk=;
        b=V3O3fG2FlK8cd0lAJVtc00bk9jZoyoCsUI0VW9JWOl+iJ/ITg6wlukFLF9twld84hA
         Gs7eU56wwf5/nD9b9dMQbXhgyX5u/e9nW9n849C+Aq+OibmNrpBANIhIiDgv2iJsYjP3
         HQsdP/uJVbHHAGZTQIt1VETVWlTlKRe/Chcj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EOsBI4bx682EH+eLRWoUpJArKHquLRzD+oXAiBLaGS9kOhrcjAPdPARHortBzrhQOF
         p1vVa0NF3gZnqtnFsAo9sXWTXud/lGbvyPXDV0Q7scvSMBZ8xphJsSmt6U07j8H7/kt+
         FGrafsyFs66NkMMZpxXXolEoPG71f5cJaPdSc=
Received: by 10.70.16.8 with SMTP id 8mr12761030wxp.65.1218563716029;
        Tue, 12 Aug 2008 10:55:16 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Tue, 12 Aug 2008 10:55:16 -0700 (PDT)
In-Reply-To: <1218553338.7264.14.camel@heerbeest>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92121>

On Tue, Aug 12, 2008 at 17:02, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> On di, 2008-08-12 at 15:38 +0200, Petr Baudis wrote:
>
>>   how exactly did you get the morge conflicts?
>
> I'm not sure, cannot seem to reproduce them anymore.  May
> have been pre-0.2 issue or another goof-up over here.
Could be, there was a fix for this from me. If you have a
.git/info/gitattributes file, you where hit by the bug. But with 0.2
this is gone.

Bert
>
> Thanks.
