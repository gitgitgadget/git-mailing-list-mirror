From: Alexander Nestorov <alexandernst@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 16:22:52 +0200
Message-ID: <CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <vpqsj0fr19j.fsf@anie.imag.fr> <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
 <vpq7ghrqzrv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:23:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uowos-0000u5-JS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab3FROXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:23:34 -0400
Received: from mail-qe0-f48.google.com ([209.85.128.48]:34138 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868Ab3FROXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:23:33 -0400
Received: by mail-qe0-f48.google.com with SMTP id 2so2451196qea.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=Nb3f0/aBGdIUgtwffOE/twxw3Lga8oRAwz87c1PCD6s=;
        b=ZftHbjbIzXM5GG83sgm2C8iKVqAdPR8SYMVz45iEF7kePm2QITneOfyHuugOjBMFE5
         NGHUMlmduO2utzs6iwfArJZoyfHioQ+pPTtN2GQ23Q3QoPyGSp4f7mrl4FX4KglOqabK
         UbhjZP/+2yR6NcnswIYFot0961UW5k0whE16+R/NNOqkSd5km8p5YcSouZrUocdhvbHw
         uLipdG9uhcXeeofgMAjBIg5HEUzKKDv3LBivdgqyDi3dIG1KwUY/Y9iYqfAHF7/SZ64y
         OIYwQXFuzZejsiFq1THg7YX4l8KeNac4GU8eVDwjRfUIbf8DianYQxdyHBvuDITKarVR
         2+dg==
X-Received: by 10.224.172.1 with SMTP id j1mr1149494qaz.11.1371565412265; Tue,
 18 Jun 2013 07:23:32 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Tue, 18 Jun 2013 07:22:52 -0700 (PDT)
In-Reply-To: <vpq7ghrqzrv.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228236>

Indeed, "git update-index --refresh" before "git reset" did the trick :)
Anyways, what about the proposal? Should it be implemented?

Thank you
