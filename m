From: Adri Farr <14farresa@gmail.com>
Subject: Quit git difftool on error code
Date: Sat, 25 Oct 2014 12:40:37 +0200
Message-ID: <CAPfWmhgS8JXyXz5qp04+faqjdeHsydBz-fui-HeNhF3wYLv71g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 25 21:44:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi7GT-0001VQ-2S
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 21:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbaJYToh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 15:44:37 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:58164 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbaJYTog (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 15:44:36 -0400
Received: by mail-qg0-f42.google.com with SMTP id z60so2436756qgd.1
        for <git@vger.kernel.org>; Sat, 25 Oct 2014 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KFzB0Dt3VLg4pQmD8aKNxvy1E5+pS2UxXyoJXNy0JH8=;
        b=ALiqPAvYUyGq2RNsFMpm0faw667TEGh+zcMB3VBcO/bwqFNqYKHrDEg5tAzeSR+S0w
         BH7Wl+KzxuBC5MUxyRPbeV309fmACzaw53298rStwFtxgBE7Lo4iUFQfw3rZnyX/YV88
         IPngKpoHYFPo7dsV89h+IzEWEs+yBGb2Cc1DKY5pP1FeC70CZ9pfrV9PhL4fIoDAbwe/
         ZJsVPrcB1jpKRojGe7azoDHwVuplEQQDcvBLzEiJCau52TNmToDC7daXmagSMSgPDF9L
         olg8gIWm1bJviLBQqQ//YFLI8Rkakt1fLajNMQnO2WJFp6Nau8xi1q75zGCPCzRsQIP1
         kkLg==
X-Received: by 10.224.26.5 with SMTP id b5mr14394207qac.12.1414233637247; Sat,
 25 Oct 2014 03:40:37 -0700 (PDT)
Received: by 10.229.126.6 with HTTP; Sat, 25 Oct 2014 03:40:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!,

Pardon my ignorance, but I haven't found the solution anywhere. Is
there a way to make git difftool quit when it receives an error code?
I have vim as my difftool, and if I quit with an error (:cq) when
there are pending files to be diffed, git difftool doesn't quit and
keeps pushing me files to be diffed until there are no more pending
files. What is the best way to get out of it?

Thank you
