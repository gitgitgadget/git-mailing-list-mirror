From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 23:21:35 -0400
Message-ID: <CAM9Z-nns0AYDne8Jp98_LUupLZLv+CvXU7JTzrO32MqyGnqWJA@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 05:21:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URwSj-0001cR-UG
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 05:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935469Ab3DPDVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 23:21:37 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:57623 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935246Ab3DPDVg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 23:21:36 -0400
Received: by mail-wi0-f179.google.com with SMTP id hn17so27647wib.12
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qscNfgeOqdVYORaBJ8Pq/+XdKudw8HW7nUK7ivtKkQU=;
        b=zsZj1gM1/N584bm5zecuB7toISvWLvx95JYoSFYjCWFg+LWH6TG3l2n2vu2OWXaHFb
         ym2furQKZ7VhfMYMy6KMQAGWIx4i4gn/5X6CBDjl8lpg0IlZVGKN0TYel/4zB8R2zE2D
         OzbziusMBbgAZ8uz3NkH0giE1pAr8IdBnQnO+7YSpyT4D+eKdHc65lKk0owpVJfqs7mS
         yFYnRIMMx1/e0fZLa80VagtqgobYOtMv7Uu03DxVj0Nj1MVegFdieRsKlpCxc20LywNj
         ss8Rrt/kpUStpE6SEUnxUY0rx/6zfTIPFnops/tz4XZwlQRoBBzuc0dBM80o3WW7UC2y
         A7IA==
X-Received: by 10.180.73.6 with SMTP id h6mr1668051wiv.27.1366082495722; Mon,
 15 Apr 2013 20:21:35 -0700 (PDT)
Received: by 10.194.163.101 with HTTP; Mon, 15 Apr 2013 20:21:35 -0700 (PDT)
In-Reply-To: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221354>

n Mon, Apr 15, 2013 at 4:28 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * jn/gitweb-install-doc (2013-04-15) 1 commit
>  - gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM
>
>  Reword gitweb configuration instrutions.
>
>  Will merge to 'next'.

While the re-worded text is easier on the eyes it fails to note why we
don't just dump our idiosyncratic way of doing things and just make
the system-wide defaults act individually. This information is useful
to system administrators, as it explains what is actually going on.

--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
