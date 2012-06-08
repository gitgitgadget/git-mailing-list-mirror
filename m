From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 09:18:44 +0000
Message-ID: <1339147124-ner-3533@calvin>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7vwr3ieo0i.fsf@alter.siamese.dyndns.org>
	<20120608093257.Horde.eeddeHwdC4BP0aqpIrqTaVA@webmail.minatec.grenoble-inp.fr>
	<vpqfwa618zv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 11:19:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScvLx-0007h3-MW
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 11:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934031Ab2FHJT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 05:19:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49505 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760643Ab2FHJT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 05:19:28 -0400
Received: by eaak11 with SMTP id k11so926976eaa.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=jOOw0+xHx2UEn5w1OUrrBdtnDsH4FNRQLaeFKoQiTmY=;
        b=eAjZoUYRgguoz70CMdugnRpGrwYdIROa2xEIwxdri4ZkMuxTyuC7xFys0jmGdrYfmT
         2Dw8QJzOHni7yn7yU5xgjs1yFt2l60C2BHzHMtzw18j1XFUX6UAfia0pV2B/DBIDx4s7
         O+SAWkc/VOD3yhh30ScqR8uSvhLqgWQ40iKAg76imzZWiXeHogprtZryLTMO8rSkyNu5
         eo+lwu5RaTSZQyUH1rcL53qhPPUKRyySezLtwcWljBPtQyPa+/Vhitq2DIxe5Y9LCtUM
         hvsXGYNAuvw5Qg2/xdkXgQeuoWKEWUAOW2O+I4KboRkXfSNdf51w/AMOLnc/ar4L7JNz
         Lrug==
Received: by 10.14.53.77 with SMTP id f53mr3202380eec.68.1339147167208;
        Fri, 08 Jun 2012 02:19:27 -0700 (PDT)
Received: from calvin.caurea.org (cl-52.zrh-02.ch.sixxs.net. [2001:1620:f00:33::2])
        by mx.google.com with ESMTPS id g51sm19981127eea.14.2012.06.08.02.19.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 02:19:26 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 728E341B625; Fri,  8 Jun 2012 09:18:44 +0000 (UTC)
In-Reply-To: <vpqfwa618zv.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199476>

On Fri, 08 Jun 2012 10:52:04 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Isn't a more conventional way to do that
> 
> sed -e '...' "$1" >"$1".new
> mv "$1".new "$1"
> 
> ?

Is sed -i not portable or what is the reason not to use it?
