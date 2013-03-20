From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 0/6] Support triangular workflows
Date: Wed, 20 Mar 2013 21:06:32 +0800
Message-ID: <CALUzUxq1gJY_gSQt4iffrVzawx6Qk4=BWnPoCsZqFeHUpkgwCg@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 14:07:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIIjh-0006WG-GF
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 14:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab3CTNGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 09:06:54 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:50557 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab3CTNGx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 09:06:53 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so2873464lab.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=j/8qETMnzUWWm0t2HMDRzXFSBM+nHa2JI//0fppA0C8=;
        b=NfQkrpm+/XrrTPhrOwSnvKJ0JzUcHRl5wdMrOXSdw3Q+kJn8hxxiy1B1w3OYEQK81E
         mKg+A+4xqm1oaNyyd6xqDfLhK5/sj7Ua71M0Zdnt4wWACW3oBQgJXG+53vPnVRAKgfDg
         a2VRuCDM6VKxe91HCKbPMEuiicOFv36EI00+fbxp3X9kwEJygPEHhL18JDG6fDZ/LTKl
         whB9fq0BGFuT59wpLzUbt0jzw3cmoY0mbN59N7EfhyyIqXCc2Xm5L/GeTvOp6YqVa5ns
         upVBKMvdJxlE7zSli9xF/Z+l/LS82vi++rcbidTABSBfgDd4NpMrpVweMb/MptgLFWyS
         yG8w==
X-Received: by 10.152.111.5 with SMTP id ie5mr5330951lab.31.1363784812279;
 Wed, 20 Mar 2013 06:06:52 -0700 (PDT)
Received: by 10.114.57.41 with HTTP; Wed, 20 Mar 2013 06:06:32 -0700 (PDT)
In-Reply-To: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218606>

On Wed, Mar 20, 2013 at 8:44 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>   remote.c: introduce remote.pushdefault
>   remote.c: introduce branch.<name>.pushremote

Perhaps we should clarify how this differs from remote.pushurl in the
documentation for it, in git-config and/or git-push. Maybe even
include the design decisions behind it from [1]. :)

http://thread.gmane.org/gmane.comp.version-control.git/215702/focus=215717

--
Cheers,
Ray Chuan
