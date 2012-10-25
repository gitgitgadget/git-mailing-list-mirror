From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] __git_ps1: migrate out of contrib/completion
Date: Thu, 25 Oct 2012 16:19:29 +0200
Message-ID: <CAMP44s02XfVXhJnXqLWwyCE34nW_E-aCx3s=CKc783u7EO2WLg@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<20121025005106.GA9112@elie.Belkin>
	<3B606942-D194-4148-AF6E-1F3283C983ED@googlemail.com>
	<20121025074549.GC15790@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Danny Yates <mail4danny@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>,
	Ted Pavlic <ted@tedpavlic.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Dan McGee <dan@archlinux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 16:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TROHh-0001ie-LA
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 16:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759854Ab2JYOTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 10:19:33 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65198 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759747Ab2JYOTa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 10:19:30 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1615064oag.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1IU68OdzP+34r7Ot6KTd1ybMSJlvqtTn0hObHdRJtYw=;
        b=JUXXilLcw9paBW6FNpZalSWIsAv6uW7NeR5mP44qbL++uDJPQ3A8FXIhb3ILp/eNyx
         M8arq/tFR561Q4Cfp/58vns9o5i4OtuUCZ+l4Q0XwsP8X2IOt2f5vzE5K264q9l/MlAr
         0PZkUQxL7SSo1G+rc10x2eeqlJT0GoEcifXI/DyDR1NmVYx6GRQPt0p9QtZsHLkLdQbK
         4MXSmNeYptFfAAZKJeGJadGp9qCFDcJSkh18i1riIEx2mJJIR/VGh1CrbtFBHhdfhyio
         hnNNHxQQdbA2qMPa4T5SHzxI/v8cQTfiHA/rb6GQhASUU9+IZbIY76z94cAehIUynV8d
         Mpmg==
Received: by 10.60.12.233 with SMTP id b9mr17212385oec.95.1351174769749; Thu,
 25 Oct 2012 07:19:29 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Thu, 25 Oct 2012 07:19:29 -0700 (PDT)
In-Reply-To: <20121025074549.GC15790@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208400>

On Thu, Oct 25, 2012 at 9:45 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> new file mode 120000
> index 00000000..a4fbb216
> --- /dev/null
> +++ b/contrib/completion/git-prompt.sh
> @@ -0,0 +1 @@
> +../../git-sh-prompt.sh
> \ No newline at end of file

^ no new line?

-- 
Felipe Contreras
