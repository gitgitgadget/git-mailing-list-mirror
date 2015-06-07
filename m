From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCHv2 3/3] git-p4: fixing --changes-block-size handling
Date: Sun, 7 Jun 2015 18:58:15 -0400
Message-ID: <CALM2SnZShkETQoQuNc8e0GsPWzODQACzwjh1qCGeajiN+5sjaw@mail.gmail.com>
References: <55747A05.3070704@diamand.org>
	<1433712905-7508-1-git-send-email-luke@diamand.org>
	<1433712905-7508-4-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:58:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1jWM-0001YJ-Fj
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 00:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbbFGW6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 18:58:17 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33665 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbFGW6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 18:58:16 -0400
Received: by padev16 with SMTP id ev16so25901374pad.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZU0Aux6hpa6xUHvy582afWizKBgS3SV0m/I2PFoTAxM=;
        b=VyQ8oe8IqL4czY+pYBgGSNlVvw33PLIWGyIm0JnxL+NgASejbB5jeAtRXrpuu6nEFm
         geCTZW42UKgWjFQlH0MmdThR1CHKpQYCQZDob85SOPKTGlfi5/abDj9uXvioKGBXRXXd
         XLU5VGffK7LrZzNgwS9l/KzV/D8e/Z9YE1/u+qpNrRaAhCSdo9cZT1FICRcq+yy/LbmD
         1gmmIy3IyGfiTVeS2j5t6+BV9nyNErb7O6W0M21zbidERSnm9+9NAinpxBHovTGvYQu5
         uTw9fGsDX5G0vXrd2lJ/lZv6oB78K7fRd3vNCvG+EIA4Bpx/UFAGXRAp+q753KH0jc7f
         PYYQ==
X-Received: by 10.70.135.168 with SMTP id pt8mr24466611pdb.8.1433717895675;
 Sun, 07 Jun 2015 15:58:15 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Sun, 7 Jun 2015 15:58:15 -0700 (PDT)
In-Reply-To: <1433712905-7508-4-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: qlG1sOydhf9Y8puaUc_gluW4Tqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270985>

Unless I am reading something wrong, the "new_changes" variable could
be dropped now. It was needed for the -m version for detecting the
smallest change number that was returned. Otherwise it looks good to
me.
