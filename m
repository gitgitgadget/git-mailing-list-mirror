From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v3] remotes-hg: bugfix for fetching non local remotes
Date: Thu, 25 Jul 2013 23:10:24 +0200
Message-ID: <CALWbr2x9fG=diZPN-Wkq+-7bstoVmN_pnXN0EPi=4MZQVRuYXg@mail.gmail.com>
References: <1374712977-3215-1-git-send-email-dev@joernhees.de>
	<CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com>
	<CALWbr2wN6k8JBCwLFC=TjTC_sg7Uh8AEsMOBKfH9aBxDEcV4oQ@mail.gmail.com>
	<CAMP44s2v+CF7x+S6_47CiPb6RMXu+iy06gqWNjus4vff5J8z3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joern Hees <dev@joernhees.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 23:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Snu-0008OE-9O
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 23:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538Ab3GYVK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 17:10:26 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:40205 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab3GYVKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 17:10:25 -0400
Received: by mail-qc0-f180.google.com with SMTP id a1so1215792qcx.11
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9Lrnnr7zeE+o5n4vGypnRmTXsPrsPT5FbG3D7WtzBvk=;
        b=lppT9Kx3V8MDalIa/SOugTWoGxXKkE1XJ17M58Ui1p2TXn9o0y9ND12NIpA0cJJFKi
         eh4K1bXHEWgXdLE93W+7PkXt7o07S4AiWPyQlJEfFxwBCUp3peOhOheXCj8wOjEXdlA7
         28BHfjKvY6pJdRtmx5sOaFWRjegIZW1GCkHx2d5+a7JnnfeO63K6ARu3IaeKh6utoaq0
         bwlTOnwXCZHXaImcPIZYlYrpxoj986AqT9jQOSGNqYZGkyfHaiJBNlMHZlb1RQOkiDGG
         bt1gVUqpVJqvEWKDKjNF8FWypEiX4t3MQM8pMwkC9N2xXbI3Se/SAz7kL6s5mhmDjVtN
         lJTw==
X-Received: by 10.224.32.131 with SMTP id c3mr38900794qad.62.1374786624935;
 Thu, 25 Jul 2013 14:10:24 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Thu, 25 Jul 2013 14:10:24 -0700 (PDT)
In-Reply-To: <CAMP44s2v+CF7x+S6_47CiPb6RMXu+iy06gqWNjus4vff5J8z3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231152>

On Thu, Jul 25, 2013 at 10:40 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> That's true. Maybe something like:
>
> for x in repos:
>   local_hg = os.path.join(shared_path, x, 'clone', '.hg')
>   if os.path.exists(local_hg):
>     shutil.copytree(local_hg, hg_path)
>     break

I think that would work, but I think the patch from Joern Hees would
have to be reverted first (as it's merged in next)

Cheers,
Antoine
