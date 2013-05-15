From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] branch: show me the hot branches
Date: Wed, 15 May 2013 07:08:21 +0700
Message-ID: <CACsJy8BQ=+rEfnBj3hqOdWNJXuONB4tPTwY=h1UDM0t++ds9HA@mail.gmail.com>
References: <1368475365-18680-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 02:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcPH6-0006oR-KD
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 02:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758733Ab3EOAIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 20:08:52 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:60284 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758674Ab3EOAIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 20:08:52 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so1272297obc.41
        for <git@vger.kernel.org>; Tue, 14 May 2013 17:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=v/NkkQ9Md9XakiMaV+ZeHZx2RBN9S1ojtD5Oellgofo=;
        b=awgD24DEIk7JCp6vaYgLx4K659Z3a9MzXbE5JEhDpJIV6xS1M2n5GyKnxtWEpc5Ivh
         2VdfnhJXYHcAxDD9cVmEizaSOPlbutDlUEAMgJnJMRVLgTyXe1A0idTj5cfQ1AEzaTMi
         6aidETzmkpGkvZIg8YweJskMwEift2y7yQd82wdRX/9lxygnAhumj2+8IJ5CFU05xTua
         ing7vdJ1PF0e9yx+f1em4VUd8SRtV++Oq2izO2YsoYXYjBsbk2waEGsO6ByDyudscFvq
         GIVL0I53HAOxzOvDZhTSC9lCjyTbf51F+ujYpuz3tH0b6IatWLZg6mP9C64kj1JRYU66
         H6OA==
X-Received: by 10.60.60.73 with SMTP id f9mr6313045oer.43.1368576531492; Tue,
 14 May 2013 17:08:51 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 14 May 2013 17:08:21 -0700 (PDT)
In-Reply-To: <1368475365-18680-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224374>

On Tue, May 14, 2013 at 3:02 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Uses commit->date to sort displayed refs.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Just had this idea and wrote it down in five minutes.  The
>  implementation is only meant to be indicative.
>
>  Isn't this awesome?

I tried a more generic approach a while ago.

http://thread.gmane.org/gmane.comp.version-control.git/188705
--
Duy
