From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Conforming to pep8
Date: Fri, 09 May 2014 11:14:43 -0500
Message-ID: <536cfef388fd_ce316372ec71@nysa.notmuch>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
 <20140509035759.GA9051@wst420>
 <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
 <20140509051623.GB9051@wst420>
 <536c815ee0b9c_182dd0d3104b@nysa.notmuch>
 <20140509072820.GD9051@wst420>
 <536c8546ed6fd_182dd0d3100@nysa.notmuch>
 <20140509074402.GE9051@wst420>
 <20140509160130.GA28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 18:15:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WinRk-0006zC-Jh
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 18:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbaEIQOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 12:14:49 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:52214 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbaEIQOs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 12:14:48 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so5112236oac.39
        for <git@vger.kernel.org>; Fri, 09 May 2014 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ufelJFprWP/UMe+rOsvha0vTD53apHfk6pk6QUjg08c=;
        b=IR6GriynW07emyYc9yIOXz8IdCw9KIZOVuVmhGhGjM5fiH1cWN7MN8LGTfHlCKuEQ1
         lCwIbxXDKQaHij3gauo7eLMyZEaRCpQwVHFm3Hv9aqdb4yubS+OmilbGYisC8avQCUNt
         ga2rd83+N4w67B2t+xGYJ7qX9xcDEDQtkCybcn9fReGbbvHMfc+zDXXInR8fEcOh/UAI
         J58fPyGnYoavQIEs2AT0OXBn6QcdCZgufgbhH8GpjWydWALv1Usk7IfpSb8rvLgua8eQ
         Sh+rn5/1IbTdxkDpp2iajPn0ucPkJW3khsGirpwgYnJldA/UwY7Kf+gsd1R28LbTWhXN
         s+tQ==
X-Received: by 10.60.102.198 with SMTP id fq6mr14933652oeb.6.1399652088233;
        Fri, 09 May 2014 09:14:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm3809870obm.2.2014.05.09.09.14.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 09:14:45 -0700 (PDT)
In-Reply-To: <20140509160130.GA28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248581>

W. Trevor King wrote:
> The indentation for the closing parenthesis is optional [2].  You can
> of course do things like:
> 
>   from mercurial import (
>       bar, baz,
>       foo,
>       )

I prefer:

  from mercurial foo, bar, ...
  from mercurial baz, ...

-- 
Felipe Contreras
