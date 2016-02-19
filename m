From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Sat, 20 Feb 2016 00:02:35 +0530
Message-ID: <CA+DCAeSH4S9F-1Z90cxbNNJu-6KTuOB_Jro9UdYnTAQGx3xzOg@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 19:32:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpr8-0006O3-2i
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949310AbcBSSci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 13:32:38 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34944 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946084AbcBSScg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:32:36 -0500
Received: by mail-qk0-f180.google.com with SMTP id o6so34227503qkc.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 10:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6SomOapdvSrOL1K4Cqac/N6Wv8JvDePXlWn8+67xVxQ=;
        b=Z8KVOFiFr8ETTylKHy5ODgfngEnW+7x17wWBYxiPU98zrceQGkcpMgKThxUdsNHYfT
         4ZdBlygM66L3Qhe8eHq0JNNxRKhsTBabgna6f+V9+yDe0ovhJzCMa261H8YnkW0vn0PE
         mFW4fa338hRFdxuYh+V9kiwA4ZgYJgBc66t8a3nnDkLUwkqZxccvsrbek+P9hmlKDA+L
         ITwiqPtFFSMf9jy6H5d85yjAwWvMxxbhhPzy26lLCgtjN66kZPaipodN3/Qb0rWNyLEV
         1jIQKxJhtydg7syUa64dQe89OsI0zkHTjymrbkrTF61CrhkEGBjoDztjVACI0D4OMkH7
         t3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6SomOapdvSrOL1K4Cqac/N6Wv8JvDePXlWn8+67xVxQ=;
        b=FPTTWlMP5etDunBawKFJtMexaT00umdWk/vFSnAZTTh1Y31lltzCU/upWymf3ZzQEI
         v5Fu4S+JA3tvDe+xXRFU0IyP2woDeavOHIXvZ69toL1/Xi5iAhsCojA5YlgjFI+/LN7e
         C1pBSzOFDoS09rN5qkMZo5/+xpfJSUjRsiUE7woXqWMNgjzOFPExpmHAQtKUm2UUhHrr
         mtosNzS6vqAckhRUstS9+9mph6Z8Y9HHetv+wBMNBMTfoNF9Nkya0GIAv69GTgYbonMt
         n0A08WpzBQhKB/aPjSk5m2T4l7WO3hPrlh1acyDse6bIyPHWhX5/9DyRefNo3UM5d0B3
         TfAg==
X-Gm-Message-State: AG10YORwMPD1/jHsIOroMC1X2EhpjF719pqibuO+EomhUf3bKsyF53ROn3WPWntJoYeeN/Ng88iWNaZAssqAZg==
X-Received: by 10.55.54.201 with SMTP id d192mr17617278qka.23.1455906755072;
 Fri, 19 Feb 2016 10:32:35 -0800 (PST)
Received: by 10.55.166.10 with HTTP; Fri, 19 Feb 2016 10:32:35 -0800 (PST)
In-Reply-To: <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286737>

On Fri, Feb 19, 2016 at 11:20 PM, Stefan Beller <sbeller@google.com> wrote:
> Yes, most likely t/t5521-pull-options.sh or t/t5520-pull.sh would be the right
> place as judging from the file name of the tests.

Thanks for specifying the files. I think t/t5520-pull.sh line 258 will
be the best place to write test for this case.

Mehul Jain
