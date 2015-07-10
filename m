From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4] log: add log.follow config option
Date: Fri, 10 Jul 2015 13:53:55 -0400
Organization: Twitter
Message-ID: <1436550835.4542.69.camel@twopensource.com>
References: <1436377321-8495-1-git-send-email-dturner@twopensource.com>
	 <vpqfv4xafpp.fsf@anie.imag.fr>
	 <xmqqegkhw8hf.fsf@gitster.dls.corp.google.com>
	 <1436463511.4542.27.camel@twopensource.com>
	 <xmqq615tw6vn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:54:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDcUt-0007ju-Mc
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 19:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbbGJRx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 13:53:59 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34391 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932918AbbGJRx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 13:53:58 -0400
Received: by qgep37 with SMTP id p37so40593503qge.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 10:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=5MUYJBkr/xrsinwnwLTHU04vp/mwO4202xIBJSKdNis=;
        b=LrINKDldddkQu3ArU7vds4/wuX7JFmznwKsn7Afcd53QaIyRmVdvA6OqGdXQbjMBAM
         LlkimOPiNTw+eQDFb3rYMYOG2dWsgr7F6s9vcrwHoSBBSH9DfIDNKsZoS2xgxJyGTjnC
         TW0luoBJSBFaKxeUAyJV+8aizvzgSNycNBHRZnFG9uRcKeG1UAWrYwSm2t2Xjzw3qpp9
         HjjA+YVV414GbUiE/5UNkA6qEVK2SozWuTI+pzo62kduUDk2ZE2Hf73j04yfqVVXWEgZ
         LXA+xbPausu7jfhlu1F6CZavsclbwsVPSLw73sCKBJlf737JuR16SNXzHeGPlXBfXdx5
         HPZQ==
X-Gm-Message-State: ALoCoQmwCAnsMjqIElnaRdsneDplVNkvI/mR7vUGpOV4KJo6Kg7YlP62KP8e8QTwg3UR/gmQuVrn
X-Received: by 10.55.52.12 with SMTP id b12mr35159122qka.22.1436550837694;
        Fri, 10 Jul 2015 10:53:57 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g81sm6013602qhc.8.2015.07.10.10.53.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2015 10:53:56 -0700 (PDT)
In-Reply-To: <xmqq615tw6vn.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273829>

On Thu, 2015-07-09 at 10:58 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Thu, 2015-07-09 at 10:23 -0700, Junio C Hamano wrote:
> > <snip>
> >> If I were David and sending this v4 patch, it would have looked like
> >> this.
> >>
> >> -- >8 --
> >> 
> >> From: David Turner <dturner@twopensource.com>
> >> Date: Tue, 7 Jul 2015 21:29:34 -0400
> >> Subject: [PATCH v4] log: add "log.follow" configuration variable
> >> 
> >> People who work on projects with mostly linear history with frequent
> >> whole file renames may want to always use "git log --follow" when
> >> inspecting the life of the content that live in a single path.
> >> 
> >> Teach the command to behave as if "--follow" was given from the
> >> command line when log.follow configuration variable is set *and*
> >> there is one (and only one) path on the command line.
> >
> >
> > Thanks.  That version is much better.
> 
> No, thank _you_; we should be thanking you for helping us improve
> the system ;-)

Do I need to re-send, or will you queue your version?
