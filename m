From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 1/3] git-instaweb: Fix custom apache log placement
Date: Fri, 23 Jul 2010 08:40:21 -0500
Message-ID: <AANLkTimV0kGRMwxYxQu8jgWsiwTC_msU+2QWNAmYZuYe@mail.gmail.com>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
	<AANLkTiknXtteX77h8Uy1JuWmGLWSSRkAGkS3INMOHBoJ@mail.gmail.com>
	<20100722234256.GA19581@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 15:40:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcIUH-0000fh-Sy
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 15:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab0GWNkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 09:40:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58137 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab0GWNkX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 09:40:23 -0400
Received: by wwj40 with SMTP id 40so4583442wwj.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K5zSmnM4tIMuUmi2o8ubWO+FLMIjTNiheeuept8Fz7Q=;
        b=IOQsrDOn3xuUauQpQ6tjpqzuk49fH/qD5UEQnij5wNRYyx7aWlZVPYGyRGtaz0mA4v
         Rk20dSmSDnVWSRXokXz8pjM0TcGFH2w0NhjkJso3/OoHyQ8PO3ecFkvAs3+dzGAiKgDY
         Tjjn5OKJwzvBUDHL/Nquti99l+Z5HCIzyvZ0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JJPT6DlQE/TbGgmW5KxpwXqPwtuUPRhfc40WsGUU5g6h/uyrdbpCDELMr0WPl4goj8
         GFPMS+dIoV5q5MiqWmqMG4fd40lWvNzOjdI+fqq4RpcRhtU35rbyzfU6lYS+7lQB2/EG
         V6tNnzLX51SwzGsXkUiCAfMVGbP5ElOXlsd3I=
Received: by 10.227.20.77 with SMTP id e13mr3534065wbb.12.1279892421663; Fri, 
	23 Jul 2010 06:40:21 -0700 (PDT)
Received: by 10.216.177.209 with HTTP; Fri, 23 Jul 2010 06:40:21 -0700 (PDT)
In-Reply-To: <20100722234256.GA19581@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151531>

On Thu, Jul 22, 2010 at 6:42 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Dan McGee <dpmcgee@gmail.com> wrote:
>> On Tue, Jun 29, 2010 at 9:44 PM, Dan McGee <dpmcgee@gmail.com> wrote=
:
>> > 'CustomLog' is provided by mod_log_config so we need to include th=
e module
>> > in our generated config. This was added in d94775e1f9a.
>> >
>> > Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>>
>> I noticed this set of patches didn't go anywhere...at least the firs=
t
>> two were more bug fixes than improvements so I would have expected
>> them to get into 1.7.2. Did they get lost in the shuffle?
>>
>> 1: http://marc.info/?l=3Dgit&m=3D127786592330110&w=3D2
>> 2: http://marc.info/?l=3Dgit&m=3D127786592030105&w=3D2
>> 3: http://marc.info/?l=3Dgit&m=3D127791591706076&w=3D2
>
> Hi Dan, can you address Junio's concerns here?
>
> =C2=A0http://marc.info/?l=3Dgit&m=3D127791382102449&w=3D2

I did already, and got no feedback...
http://marc.info/?l=3Dgit&m=3D127791591706076&w=3D2

-Dan
