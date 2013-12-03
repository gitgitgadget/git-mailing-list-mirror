From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Branching workflow
Date: Tue, 3 Dec 2013 20:25:02 +0100
Message-ID: <CALZVapkvVNxb-jJssZqjT-Y8sApK8O1pe3xTB8guNtx9Md2W6Q@mail.gmail.com>
References: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
 <xmqq8uw1oij6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:25:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnvb8-0007S4-9S
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab3LCTZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:25:26 -0500
Received: from mail-vc0-f179.google.com ([209.85.220.179]:41515 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab3LCTZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 14:25:24 -0500
Received: by mail-vc0-f179.google.com with SMTP id ie18so10458088vcb.10
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 11:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OodDi/T/kootCnG0LH18p1oQigHgiit4i+vTsPTb6V4=;
        b=HlVXx3yaDlSc51Hr2R63YIta08XoJAg4OJ/mTk5C4waT3LA6xPLfNT7i7pSVkEofzO
         4JllIypc8X2kC8PAx8QHwplzjU/SPA5d8/c/qouIgtyhKU17iJFsC4Tk7MfOQX22ZtKk
         cklYWo3KOUVtB+nFmmAfweRn5GYy3wjXJ3g4rnXkuIfEh/VDvU5kUjFhJJ0vzhcoxQC5
         N0APnPpy+kxfLE20ld9+FPAonuZnT20CHR+tfVN4abNbftkVA/1d/01hFG0irLOg0ehv
         DsJwSZBwhtTBnC3rXbB/beddO3zpgAHe5AxJZFJXM2ELM1OUUEP0vLkibnps7G9zCJ99
         pkZg==
X-Received: by 10.58.216.74 with SMTP id oo10mr56726545vec.0.1386098723839;
 Tue, 03 Dec 2013 11:25:23 -0800 (PST)
Received: by 10.58.233.203 with HTTP; Tue, 3 Dec 2013 11:25:02 -0800 (PST)
In-Reply-To: <xmqq8uw1oij6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238721>

I will start to rebase all feature branches because I have no real
dependency on those, but master needs to have a linear history, as I
build from it regularly, and I need to assure that people can get a
previous version of master.

The problem with that is that I wouldn't be able to have a linear
history on master. I had also thought about doing a snapshot branch of
the integration branch, so that I could maintain history of
integration, and just update it with integration snapshots, but I am
trying to get another more git-ish way to achieve all these
requirements of all branches (they are really driving me crazy).

Thanks a lot for the idea. I will mantain clean feature branches from now on,

Javier Domingo Cansino
