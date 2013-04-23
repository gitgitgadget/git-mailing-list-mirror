From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 1/7] am: suppress error output from a conditional
Date: Tue, 23 Apr 2013 07:38:37 -0700
Message-ID: <CANiSa6i+jsZUBgeQcQq2C=d009dU=i6+g35-HoofedaEJRmzTg@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUeMl-0005IC-HT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab3DWOij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:38:39 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:55204 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab3DWOii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:38:38 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so6171502wiv.8
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dy8wUkfh1rnm2w3kPDKfvyngMRLIHopkXvqCv1OdehE=;
        b=k3VWqyHXPs4hBjtf+9WomB6/0YMKQT2lOwtN13MvTaMQPfTmETPWHmhBeevVdE1oM6
         X9eR9W9MK+w/+iR45of9Vs9O71AUqAoAIwGDHYHMdjJUcORSltTwcwNSQrfXLH572duo
         jV0H9y4SsR1+t8iRixE4fkBvPeqJqRQwXJSytTsbvhNFQHWi4ohEPgpejCnQ6RNoUHeB
         n2wH7OenhoZZN8dh6N1FkfbEeWniCuiId5XavSPeT9J5eibQ3AjDqIBQbPSxyl39X/PS
         hFZGru2M9AYbdy85CoIVNpSefqC/6XsN5is7uOvbjcFK6vckw9mAHfLr0ic5lKbF5OMn
         vPuw==
X-Received: by 10.181.11.164 with SMTP id ej4mr20042300wid.29.1366727917467;
 Tue, 23 Apr 2013 07:38:37 -0700 (PDT)
Received: by 10.180.19.198 with HTTP; Tue, 23 Apr 2013 07:38:37 -0700 (PDT)
In-Reply-To: <1366725724-1016-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222166>

On Tue, Apr 23, 2013 at 7:01 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> When testing if the $dotest directory exists, and if $next is greater
> than $last

When can that happen? If one edits the todo?
