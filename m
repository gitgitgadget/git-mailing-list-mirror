From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] cgit v0.7
Date: Sat, 3 Nov 2007 13:44:40 +0100
Message-ID: <8c5c35580711030544k78c2490ke319dbb298923baf@mail.gmail.com>
References: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
	 <fcaeb9bf0711030515i24174694w5d4fd9b82ca85868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:44:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoIMz-0002y9-OY
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbXKCMom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbXKCMom
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:44:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:32351 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbXKCMol (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:44:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1280004wah
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m6jn33pLa66kNlUlBj+b4/y30letRQ0Mbd31l9IkS9I=;
        b=aAdoTGyGsGdkieWWOS2lo9wgfWrR9l3jyX/2QEVid/c5qd3HIkDlQV2UtfUWr0rrOg5NwIZFNng/UhirIP7OGSdGbUG7aATHEjeFev3fjGoIAklV+HWDfUgyRzKp1LDaMcf2FKL85/oM9QewnYghXMy35M/xz8Pf8rxJBi3wQOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h9pKBKckpcbgxrh0lBxHIeRaMhXV9d8Qxk53ob5s1RfpGBBNwHJmUgbad8W6VZVILxn2T9e44qAfXvDtPEKMPr6l3qaCrwgs+cuZEEAL76R56jk2WO6f23nkaxrmhortsTGX5MMC+GgKS3lR7TrKMc6zxQFhnxdrnUEsicgBeTU=
Received: by 10.114.59.1 with SMTP id h1mr2981354waa.1194093880712;
        Sat, 03 Nov 2007 05:44:40 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 3 Nov 2007 05:44:40 -0700 (PDT)
In-Reply-To: <fcaeb9bf0711030515i24174694w5d4fd9b82ca85868@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63259>

On Nov 3, 2007 1:15 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I wonder why this is not in git's contrib part.

Well, there is at least one technical reason: cgit uses git as a
submodule, so if it got merged into contrib I believe it would require
all git cloners to use git 1.5.2 or newer. It could also be
potentially interesting if/when git-checkout becomes submodule-aware
;-)

--
larsh
