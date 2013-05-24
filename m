From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Fri, 24 May 2013 21:28:00 +0530
Message-ID: <CALkWK0nTGydbAQFajUtf30XWNW3TrWDiYUWFw1KPUoHpdkyw7Q@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com> <CACsJy8CaCv4eO2YH_bUKKKZWTxSu9zd3qaDQ5kdZQaKg64ggyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 17:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfuOP-0001gx-P7
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 17:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996Ab3EXP6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 11:58:41 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:55597 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab3EXP6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 11:58:40 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so12789190iea.18
        for <git@vger.kernel.org>; Fri, 24 May 2013 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qcHuuDg7uVF2uA2LjjrsEPETZ8kM1DAM/XPynVfD2UA=;
        b=uaUUiGWIUPedZIsxLpjT/ci5+tWzhltExgmG0pbU/NL+opu7o+nRefdEe6dHz1c6Kr
         CdBO+6uMDSrLWMrNhPXPPNFukYEPa6wdfRUDz6EVM2NXh7MLcDY8KO5ktm/kwZpBLvYp
         9eUwcHZEO0k7QrJpCJ9oHp9TaQoM7B5lF2Fwpdw+9lhTLVwYTI+Hml7vfcj5VmvnVk0v
         dG/dcWS7QAMDX7pHHMNkVmwHmz52merPN0tPG655ZlyEjVVA0NTeRPxXEuUtEuEj8in1
         OycFWVBjcqLtqNmIVmy1yTV8i3gEyf/d6I0cMnQ2eRVvJtIwXAq0Wv7MFJj3hCBb9Tas
         nrJA==
X-Received: by 10.50.33.19 with SMTP id n19mr14162372igi.44.1369411120414;
 Fri, 24 May 2013 08:58:40 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 08:58:00 -0700 (PDT)
In-Reply-To: <CACsJy8CaCv4eO2YH_bUKKKZWTxSu9zd3qaDQ5kdZQaKg64ggyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225367>

Duy Nguyen wrote:
> Usefulness is one thing. Another is maintenance and in that regard I
> still think we should be able to remove -v and -vv code (not the
> functionality) with this topic.

Why?  The topic adds good functionality, doesn't break anything,
doesn't paint us into any corner, and has users.  Replacing -v and -vv
can be done eventually, after we get alignment.
