From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Turn off pathspec magic on "{checkout,reset,add} -p" on
 native Windows builds
Date: Mon, 2 Sep 2013 18:56:13 +0700
Message-ID: <CACsJy8BxGVyVsOV=XyWRqSnNjna0LQOAk6rgJ_jRkVox1jUSxQ@mail.gmail.com>
References: <521EF02A.2020300@viscovery.net> <1378001284-18426-1-git-send-email-pclouds@gmail.com>
 <5224334A.2090300@viscovery.net> <20130902092959.GA17306@lanh> <52246B70.3080200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 02 13:56:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGSkT-0006df-Sr
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 13:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab3IBL4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 07:56:46 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57706 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068Ab3IBL4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 07:56:45 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so4445812obb.33
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VmUkr7DhMM/aUQDL6QW1DLHe6uTR4yRy8mRhmo3PU80=;
        b=eYHcvbdYQ03zx265GuNYSoz8/rh2XPFPREptFEeNlUd1Hs33fc9LAZrZiJco6XJksR
         SSkkZVqqgHR3IkRfN1SfQxQEJNdlyy4JLJtNLWMcATIEG1nsV3K9IuuZEujrvKHZSxDj
         cakjzoR+l5Hnh96KNdmQSC2r83tK9I1raOyy+gaFPCXmpB/SQq54cZfP7fiBo4u0uMhy
         iQ8m4vNsOKzT3H0ORiqrn2puOA+z84+ouQd/9TlS+YR5bcScySMMXS16GMZL1TPSxhjT
         S4y3rhku8RRXqbmp63tBRzDMnakSPYESYmyYdeHkbvYhsAK2TpZpWA3bzDKywnO845MI
         WHCg==
X-Received: by 10.182.119.229 with SMTP id kx5mr16723428obb.23.1378123003823;
 Mon, 02 Sep 2013 04:56:43 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 2 Sep 2013 04:56:13 -0700 (PDT)
In-Reply-To: <52246B70.3080200@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233633>

On Mon, Sep 2, 2013 at 5:41 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Which features do we lose on Windows with the previous patch and this fixup?

New pathspec magic :(glob), :(literal) and :(icase). You can still use
them via --*-pathspecs or equivalent env variables. You just can't
enable them per individual pathspec.
-- 
Duy
