From: Britton Kerin <britton.kerin@gmail.com>
Subject: make notes show up in gitk graph view?
Date: Fri, 5 Feb 2016 21:30:55 -0900
Message-ID: <CAC4O8c9iFQHjFq2HPL-iMzJTvgWa=-e6jGusAHLzUoGC2HP-HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 07:31:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRwP8-0005Rq-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 07:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbcBFGa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 01:30:57 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36317 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbcBFGa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 01:30:56 -0500
Received: by mail-wm0-f48.google.com with SMTP id p63so52646222wmp.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 22:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=H/3o82cV0Dz6KZCTbg6I4l4FCzJixIumJyb6jr+CTMs=;
        b=rNUKOAFq/PhutOLy/DhN3ueZwcWLoMqJ/68mUycO2UF6exzipDaap/aBjYlLy0SQ5H
         Go8jtcf24KSD/Xr9Xuz1C5kFSS/rPYUhkXZn3uDGEPY/TiuJp3HyBKihwMkrrbk8xgg3
         eF7WbnuzRIThYJ+V2zPB4a5bA0gvG+5ws3ltxBdAMYhE0S9urkXDdNnd652jxqvxyDI/
         6EM5CvRMdUPnv3vbZwjSx19yy7rPi6S/xJnhmbtolL68RITNsGNsduUY2Q6Pv4mnC8gc
         F6fpgFLMJD76cYNq7Gmuu5c8jrHaeW+49Ikc7f6cTZc541/PbXl7UYEBJhUTjLyL4hz9
         4XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=H/3o82cV0Dz6KZCTbg6I4l4FCzJixIumJyb6jr+CTMs=;
        b=ei261crlphHVj90n/zRrL3nEJMzE0Q96cg8wbcau4wiUHuHh9MQDbBtAPEgvZrs6/j
         gukaYnJGmi8nWFCOlzz0olhrRKgTIrKYli+EfDtTX2qBOzTTr433kBLeTsOJv0dpSDYE
         7tcEBQnVY47CkgdsaMpg7TZlMpl6a51SnIfrpQDJx4eZa3TDionvz1a9oWXfNsDq73xF
         2341s88ezP8x6mcO91fGEPeDXWdtdHTQNWUqA4LXM/qNRU7Mzt+hv6RnFBLUIv0hR0gq
         TpIzyzRQ0wUnWUWSYpiqfBZDud+fb4e7ywys7ZoqQ9crLLM9E/kcNmMtFlM0LN7fvrOh
         23oA==
X-Gm-Message-State: AG10YOQxunrBEijKPe0CJA8l46LyKUWHroz5ruMC9h22ff95SmcJ+KObt6ouApFA21sS1r9C4xJDNP2X7XaZDQ==
X-Received: by 10.194.19.164 with SMTP id g4mr17466916wje.120.1454740255570;
 Fri, 05 Feb 2016 22:30:55 -0800 (PST)
Received: by 10.194.178.161 with HTTP; Fri, 5 Feb 2016 22:30:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285683>

I'd like to be able to mark dysfunctional stuff that ended up in the
repo but we don't want to delete with DONT_USE or something, and have
it show up like tags do, but not have to be unique.

If git notes don't work for this purpose maybe something else does?
