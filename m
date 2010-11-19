From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/6] http (dumb): end urls with slash
Date: Fri, 19 Nov 2010 20:46:24 +0800
Message-ID: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
References: <1290125163-31065-1-git-send-email-gabriel.corona@enst-bretagne.fr> <AANLkTikM8mNv+GiVyDWEJxsf0o3FYaaJj+jdYyiuXnov@mail.gmail.com> <20101119051047.GA4201@burratino>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJQMj-0000xo-24
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab0KSMqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:46:52 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47695 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab0KSMqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:46:51 -0500
Received: by pvh1 with SMTP id 1so687011pvh.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:references;
        bh=79CvA+hgbfiCCGoVEwmvP2n3nOFwp7hSCWpRh21VdNA=;
        b=rptUz962VrKqCC2frh5ztpbHwI3slJFRhXJ4feXJlk8wFQxxYD9kw0NoNLbbxNFqAR
         YZosHp711islzE41vgnC2i+twAT6OGN9MtmDodvW5sXzqG4LvDE2ZLbgAF2QCIlubcKG
         ijlKRbX5ss53+paox9OCgYIr0Tes413WaiI0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:references;
        b=N+7SF7lzkgr8kGYA3VvcCZv6w+skwzS+Erdl9sKK/ID/EfmeOo+owEfgHlJaNIZtVz
         tGzIM4HzsZIGg2vOaX60GssRowoiSmt2qj/i74To+oLWcBQgtfCM/1BQYfTSvhkk67gz
         1zSGG2XinJ9OeO/stVgLx69FsoOBhA4fsyw8E=
Received: by 10.142.147.21 with SMTP id u21mr1622079wfd.257.1290170810879;
        Fri, 19 Nov 2010 04:46:50 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id q13sm1852420wfc.5.2010.11.19.04.46.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 04:46:49 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161745>

This patch series contains Gabriel's fix, as well as some related work I did in
the area while looking through the code paths.

Contents:
--
[PATCH 1/6] shift end_url_with_slash() from http.[ch] to url.[ch]
[PATCH 2/6] url: add str wrapper for end_url_with_slash()
[PATCH 3/6] http-push: Normalise directory names when pushing to some WebDAV servers
[PATCH 4/6] http-backend: use end_url_with_slash()
[PATCH 5/6] http-push: check path length before using it
[PATCH 6/6] http-push: add trailing slash at arg-parse time, instead of later on

--
1.7.3.67.g2a10b
