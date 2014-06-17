From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Annotated tags by default?
Date: Tue, 17 Jun 2014 15:04:01 -0500
Message-ID: <CAHd499Bszq1nw=cu9UZpnodR1ZzmX2Bw2kJr8X13_mEUd7ombA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 22:04:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwzc1-0007GK-0R
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 22:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933376AbaFQUEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 16:04:04 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:65182 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932927AbaFQUED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 16:04:03 -0400
Received: by mail-vc0-f179.google.com with SMTP id id10so6831770vcb.24
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=2G8CaIrkfgpYTEB9lTaKSfR39G6cRMMVu8/6D+LWbRg=;
        b=zmFASIYZvYMwQGIxNJKG/yx12TpzVXtQybANYW8lrUK6gSzBemNd5nWHfJNxVIn+MF
         kg3VQe199tESFM3eVeqO1FNIs3qjMQGlMoz8v9cYcCIuguZhD9onfFeKhsBGovxXLj8q
         I/kWCUiTFA0n31/MJnixOnKWhG46V1aeic25OB+KIFW/tTbZTIZUVPeBZMr8KG2E8guD
         sfFU8qHWuMOvM8a9YyZ61kOnCvAVYMRBRXwFFwYdqQxNe4pdbD8PrgS1B8j0pbetkvL7
         tmBVOBXoD0bDxXRj45L3iuQzfA/c4f220eAKk19KqrFj7a/McZnK7S1rPa7Y80UbZJaf
         rVsg==
X-Received: by 10.58.248.2 with SMTP id yi2mr2083823vec.48.1403035441567; Tue,
 17 Jun 2014 13:04:01 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Tue, 17 Jun 2014 13:04:01 -0700 (PDT)
X-Google-Sender-Auth: s7liJVD2PBUlVVhdGT9FHb8Z8S8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251947>

Is there a config option or some way for `git tag -a` to be the
default? I could create an alias but would make more sense to have a
config:

git config --global tag.alwaysannotate true
