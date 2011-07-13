From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] doc/fast-import: document feature import-marks-if-exists
Date: Wed, 13 Jul 2011 15:57:56 +0530
Message-ID: <CALkWK0mkiVVAWpq2WMFZuSks4rJhrYA07Z0XyTFZUzxxmnUa-w@mail.gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com> <1310483428-29833-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 12:28:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgwg3-000718-Gq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 12:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242Ab1GMK2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 06:28:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36880 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965169Ab1GMK2R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 06:28:17 -0400
Received: by wyg8 with SMTP id 8so25891wyg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MMoiuuPKPx2vN0yZ0/9nqwp23lMFfTZDVVy4/z81a4c=;
        b=uoAB5uaZ+sX5uon5KdRNQvqVmeFcdlVbrrg3AYVFCoz3MUAoiPeYwMtLSXMMIs0d3s
         Bl745XBgmN/7zhQ0+iQrk1PNXHVGuPhHzs+RATImSau5KP/rFLTvIBfWpCHnE3iYLYwD
         Mu0caiuXA5VbBgI7jalZ8SzmW/vQsEYZdNcX8=
Received: by 10.217.3.17 with SMTP id q17mr4817606wes.107.1310552896155; Wed,
 13 Jul 2011 03:28:16 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 13 Jul 2011 03:27:56 -0700 (PDT)
In-Reply-To: <1310483428-29833-3-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177022>

Hi Dmitry,

In addition to Junio's comments, I have a few things to add:

Dmitry Ivankov writes:
> fast-import parameter --import-marks-if-exists was introduced in

It's a command-line option, not a parameter.

> commit dded4.. --import-marks can be set via a "feature" command in

Please more SHA-1 hex characters while abbreviating, and write a
little more information about the commit:
dded4f1 (fast-import: Introduce --import-marks-if-exists, 2011-01-15)

> a fast-import stream and --import-marks-if-exists has support for
> such specification too, for free.
>
> Document "feature import-marks-if-exists=<file>" command and add a
> minimalistic test for it.

Perhaps you can make it clearer that this feature was available back
in dded4f1, and was supposed to have been documented then?

Thanks for working on this.  I'm to blame for not documenting/ testing
the feature in the original patch.

-- Ram
