From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Tue, 10 Sep 2013 01:46:27 -0500
Message-ID: <CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
	<522E3C6A.3070409@bbn.com>
	<CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
	<20130910022152.GA17154@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 08:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJHic-0000GE-7X
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 08:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703Ab3IJGqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 02:46:30 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:60884 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab3IJGq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 02:46:29 -0400
Received: by mail-la0-f50.google.com with SMTP id es20so5913257lab.9
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l2gUIG5n/3UiG0Vx2Fs18NPz0KJm6AnqtBbEl9/+HRI=;
        b=XyYbsLbWaBasdI/Rm+sL+LY/Z8naH2KSZOXvG/qA4hyFFw0SguMQF+7SUjpE0wHxcC
         F1IymnzqqYyEqccJu6BhR4jyE+6T256cYG4EcFD/J6sXtM+wtiJlN2T3dxUlhQrPCX+n
         V9sXEP7cavftuQcIIavnbDD2t7Qn43uA9k8OpCw6E3Mb5gYV1NbcaJ7JxPv3BsywjeqO
         H/QRC1SFuj2KoOaESz3xODq4BCISC0VHnoRJvoIoFjujt9MVfAH1dvEodlP9/4NXR3/4
         p592UQ2yx6QF0SPdKjhHR27mN3RSL88UjV3JzOaV/01odq5DPI4HkWUoR3P2QG6zrqCg
         bzLQ==
X-Received: by 10.112.42.68 with SMTP id m4mr19902114lbl.4.1378795588083; Mon,
 09 Sep 2013 23:46:28 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 9 Sep 2013 23:46:27 -0700 (PDT)
In-Reply-To: <20130910022152.GA17154@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234419>

On Mon, Sep 9, 2013 at 9:21 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 09, 2013 at 05:49:36PM -0500, Felipe Contreras wrote:
>
>> > These deprecation warning messages should be written to stderr, and
>> > should probably be prefixed with "WARNING: ".
>>
>> Is there any deprecation warning that works this way?
>
> The ones in C code typically use warning(), which will prefix with
> "warning:" and write to stderr. They do not use all-caps, though.
>
> Try "git log --grep=deprecate -Swarning" for some examples.

I'm asking about the ones in shell, because this is a shell script.

-- 
Felipe Contreras
