From: Christian Couder <christian.couder@gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 16
Date: Wed, 15 Jun 2016 14:06:03 +0200
Message-ID: <CAP8UFD3weScg-ZVzYe0hHEvH_zC1XzTDwxFE8kPQMMSAATsC6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jon Forrest <nobozo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Joey Hess <joey@kitenet.net>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>,
	Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 14:06:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD9aJ-0005cm-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 14:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbcFOMGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 08:06:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33085 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbcFOMGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 08:06:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id r5so5483695wmr.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Zwu6N+jRMkcllARbOuqOb9ti7esp+bVbKrO5rt+7+/Y=;
        b=qbI7MW2s0xdStW2zFj0I4OulV82yZ2vO+zo+OL3ASc/JyVzCurp1niz/tcM20fL00b
         5GznTvztwmJUcMUJTR4XlYjsAy8wAymLKoE8RH+5aeUA8A7rtRvfbDshs+TwrjLIKDYj
         tdgaL4yeK+nUf8UbjQ7W7+1dPZ7bmKqRgk4vQW3jfYwYUHlLUNvrFKl8FLAvDfLeGRn1
         85q2dCZ55lIbpykwFfefEGvwsdBLihBjtRjvVhFVNgsDuqXE9j4SvYvNQc05eqjBlMX+
         0RPZtkYwaRzr5b8Qi4Fruq8KFv2Xe+xBwOk2imrhs9TATaxnbFxU0l+PbaKEjtVZQeQM
         CM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Zwu6N+jRMkcllARbOuqOb9ti7esp+bVbKrO5rt+7+/Y=;
        b=LIHvjAgqWnJmPVK837JXxt+d0SPzhSY53UvsOZIjLXbjVpOXKuRC90MF/9lb0Z52/y
         0vedC0FROQ9BHT7DVBxTJ7G4rhM3JBKwxKOUdjbN17ZInMQoVs7b2fR6hAIsY/RDjvE9
         Q6bjSElAoIUE9lVCfXXS7s+l+f1E5zPeU4AXin4EFPGxoElJMjtNAsUiU1Id6FYqhE4p
         l9nB4sXqNZsBZXSyVXODAr0V8DMwO9ZGA1/oI3P5ZkmEseKuek+bpLACaoT2z8Ng6kzw
         s5i8FZJMjtfw07DZbhbfAmbhsqdiQq7CNpqv7vHbeIgxWzH2twG5+d9wbLtNRcnGMbD7
         HfIg==
X-Gm-Message-State: ALyK8tJ/TD3yUxA9GRFomsD2T5DZF12tboIGap3rsIOWh+patjrIDcA80QYdwOZJFsRtsjKu/AZxyUL6wInbKg==
X-Received: by 10.194.239.163 with SMTP id vt3mr10893396wjc.78.1465992363622;
 Wed, 15 Jun 2016 05:06:03 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Wed, 15 Jun 2016 05:06:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297367>

Hi everyone,

I'm happy announce that the 16th edition of Git Rev News is now published:

http://git.github.io/rev_news/2016/06/15/edition-16/

Thanks a lot to all the contributors and helpers, especially Duy and
the Ensimag students!

Enjoy,
Christian, Thomas and Nicola.
