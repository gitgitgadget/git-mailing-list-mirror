From: Stefan Beller <sbeller@google.com>
Subject: Re: t7300-clean.sh fails "not ok 32 - should avoid cleaning possible
 submodules" on debian jessie
Date: Tue, 7 Jun 2016 08:43:59 -0700
Message-ID: <CAGZ79ka5J9xEW=ps6kM6Gm2NU67_hv792-dJThf=GOd0tZG-Mw@mail.gmail.com>
References: <5756856A.4020406@debian.org> <alpine.DEB.2.20.1606071229500.28610@virtualbox>
 <5756C6F4.5050300@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pirate Praveen <praveen@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 17:48:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAJAl-0000vF-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 17:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbcFGPoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 11:44:03 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35425 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbcFGPoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 11:44:01 -0400
Received: by mail-qk0-f172.google.com with SMTP id p22so43194026qka.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8ejLqO0BgZnkXBMyAMYJhSMcsru8j7CTiKDoTINX6Wg=;
        b=E+4lbf3v2zVFjhjP6x1Pa8ySb+C+db+V9u6PcFaaNhyg7orI3aXp26diV8NRa7Qfxk
         +XEsWzVi6wUVwlmRA8wTonaAeDdI3M++eL2s1wTC3pVHq2yYKyR6rIy5/ENTekJ8vzrh
         5nxjaZ4CwHSltVGnC1cRMAS3ZWl0thajo4q4CzlQiBuW9jn/GGFEp1bJEYODxllagYfv
         dADqdakP04V7wHmwb8DZgEBQVDZj6UQ7j1X+85FMEmsCJ15aBI8moDPWNgCIx0xCwxcb
         q11FPaS6GyzZtSVVXOf82OtcUyi8NOGo7uVajopIejiN0FSSd7Pt7KdZSssB0Cnlx9qc
         zyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ejLqO0BgZnkXBMyAMYJhSMcsru8j7CTiKDoTINX6Wg=;
        b=DajMIl2TmHgD+Tr3RCjQzCgwpWwJOM2xxE1Tm9gYgE5SqBo5cupbUEEg3opTy38NPj
         HX5WGTxCa0wtwz0+o52/SeTpk4XTNkdssVdVctKNJHmGoUgT4dSaaEkhcLQ4AF9JeegY
         +DLOLnj4X8TIaMAgkjSuPu0yo5qFq40D7wi/CwPTdSbtFjlCpsLUV4JyT8FqQS/zAMzw
         nG0a29oKL5rMn7PAyzfmcrqBjZ87R7hnhjR1K7iCuUHQX15KU8S8dByo7LWoyN/ekvt+
         /qFVF+nvGuaBzooJ+LetT4iM+nCyBJvxLsANzhNKw8W9NK7aYhzn0YJJ3J1frfFp6Zcb
         iMZw==
X-Gm-Message-State: ALyK8tLNnaLH1uJAAV3nLWYwpANdMj4XhWvDk/UTgIudoZbWIAdVhhv1WECAAM+LRb4R6WVsoyoalFQj32k78H7h
X-Received: by 10.233.223.5 with SMTP id t5mr77120qkf.35.1465314240401; Tue,
 07 Jun 2016 08:44:00 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Tue, 7 Jun 2016 08:43:59 -0700 (PDT)
In-Reply-To: <5756C6F4.5050300@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296693>

http://thread.gmane.org/gmane.comp.version-control.git/293025

TL;DR:  don't run tests as root, or cherry-pick
cadfbef98032fbc6874b5efd70d1e33dbeb4640d
(Are you telling me that patch is faulty?)
