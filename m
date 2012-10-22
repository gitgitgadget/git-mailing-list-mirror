From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: diff support for the Eiffel language?
Date: Mon, 22 Oct 2012 15:06:26 +0200
Message-ID: <CACBZZX4wF8C_9ok+zeTfO70BgZXufvQaJ+8B5EiOAmxvVwr54g@mail.gmail.com>
References: <508550E8020000A10000CF36@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQHid-0005np-NL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 15:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab2JVNGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 09:06:50 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37957 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab2JVNGr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2012 09:06:47 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2363061obb.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CB2c2Ak9goNPF7rkoS1wa8HbO76Q6mFdl29AAmAzCgY=;
        b=skcbo5cscSywCzRimoNaOjsAweDpf6YU0YDii6a8eudwMFq4kUM7QAMo/NRigInwGl
         3+xC/xywLwLjNFAy/cG4HnI9vlBIvp8ZGT3PZV1OVvfYmadEOUeoH4jcN217sH8wVH80
         OF19ecweLKL8ZVUBFrNf7T0CvQl9I0ORTY/23ovx4zNkxyifq8VbWyS0YbSwvwts1XaZ
         7hvWu6h9DrgiFtG8g7egoq482Q9tOPFAxYRddwSA798Kl101HgtkGKzsHS5VZTpBok52
         /KRNvXjsa6YSfDgnueLsw2f3auq/H3jbulz48uLo+bfUnDktdqapVtXLJEJ7ez2GTa8G
         1eHg==
Received: by 10.182.49.104 with SMTP id t8mr6927567obn.0.1350911206441; Mon,
 22 Oct 2012 06:06:46 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Mon, 22 Oct 2012 06:06:26 -0700 (PDT)
In-Reply-To: <508550E8020000A10000CF36@gwsmtp1.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208181>

On Mon, Oct 22, 2012 at 1:58 PM, Ulrich Windl
<Ulrich.Windl@rz.uni-regensburg.de> wrote:
> However there's one little thing I noticed with "git diff":
> The conte4xt lines (staring with "@@") show the current function (in Perl and C), but they show the current "feature clause" in Eiffel (as opposed to the expected current feature). I wonder how hard it is to fix it (Observed in git 1.7.7 of openSUSE 12.1).

See git.git's e90d065 for an example of adding a new diff pattern.

You could easily come up with a patch and send it to the list, however
it would probably be good to CC some Eiffel language list in case
there's some syntax oddities you've missed.
