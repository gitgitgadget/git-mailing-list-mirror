From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] refs.c: rename the transaction functions
Date: Mon, 1 Dec 2014 18:05:08 -0800
Message-ID: <CAGZ79kYtay40tgLA_Xey7ojWXQD=BdvZGK9ot7C8_urTxXcVGw@mail.gmail.com>
References: <1417485752-10502-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:05:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvcq4-0007tr-9I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 03:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbaLBCFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 21:05:10 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:51773 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbaLBCFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 21:05:09 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so10656554ier.4
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 18:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ejOv0ADhKIWixZ+DWfFONW1OKhnjwCj7g2QQss1BclI=;
        b=H4l48429m/Psz5ObJhaPAR2S8zN2+iSpBjAemaGLLcAv+QMp+zus5qWzujNVsYSeuS
         OTG4klESXr9fFnaUHLTQFebFA4SgKqhQH8QalLBCfTduXFia2I65HKf1wX5mnMMK+OGO
         WIttl8yOpKj/S40bn7BUwy2EqmtOeYsXZgnV1M3YSndP6g9q3ZXrY+QGc7MvrjqE8KZa
         Kv9kRNBlE/n9MyNNqfSiADfhp0DZ0W/wHcB5y+HGsAX87zPxs6hIox+Lp7KFAGTZpZN1
         TsN2qopdI+zUK2QtTTFyap6OtsV8ZewwWJaezG4G9ivHpFuZbTiHPEQUzb3GMS/6uZNf
         0GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=ejOv0ADhKIWixZ+DWfFONW1OKhnjwCj7g2QQss1BclI=;
        b=QAb8zRH4iAOyzSBcnlAQQZOxfHb6ens3WBgUEO9wVRxxdH500mb05OBtnP3Jn1dwJ9
         sLxCRJoJbUh22B9TIjqK0JjQqvporhiKYLC6k3ArfpIq4AqshYv+6xwA6uN9WrNphBL0
         5YaEuBfCBugtS4pqLntpejV0Ogxl7xJBoTkzK9z7a5AFhiu2SAsHAscB8mtFUdP17J5i
         Vv8vcWUWu0QkMCUBFc8k6hIibauQxtZlMWGo/bB2HKM5fEPlRIokxxhxZ/NhNjj4yep2
         0vuT7ogGVrpGrBNeG6tjALhPue3VdOd4eXOmvxJIcmiWXQvs6nk/JygZ0qPt01ydlbd/
         vd+g==
X-Gm-Message-State: ALoCoQmo+L7cZLfb4uuDQ8rMlPx1SMMrGn7nrvMY23pS8JehWxbWhaYq9R/RHU50XVadqGv0Byp7
X-Received: by 10.50.137.65 with SMTP id qg1mr936108igb.37.1417485908682; Mon,
 01 Dec 2014 18:05:08 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Mon, 1 Dec 2014 18:05:08 -0800 (PST)
In-Reply-To: <1417485752-10502-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260523>

This patch series is not really ready for public digestion, I messed
up sending it to the list anyway.
Please ignore this series.
