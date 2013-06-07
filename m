From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] build: generate test scripts
Date: Fri, 7 Jun 2013 17:06:25 -0500
Message-ID: <CAMP44s1t7aqOorQqhXekZ5+DSZc8vjw+pP_bjLxki9F3bo5q1Q@mail.gmail.com>
References: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
	<1370642587-32352-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:06:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4nr-0002T3-PS
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab3FGWG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:06:29 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:35647 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FGWG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:06:27 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so4208137lab.31
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ckHPlaLgOwDIJNcsyO8h5GouvmA9sEp3jLHL4PmysYI=;
        b=r6zKXrD1XxC7AGFhBzBx6Gr/EBHRBvsO+yU9qS5JpWzlMY+sF0184JArcydf3tt24P
         J0/RKBpjtJuL+0oyg9kcJsos8Bk7kjkrY+LN3E5YyVNWGZ8UHYOQ3KfURzFgW9UhNPjB
         pva92T3QL8nW0rl4aOuMht5f0qWHErW6Gpd1sgqlnc0Exo+bHeSIQecIsH1Twse0yu1t
         sSzh65q/BURb9cP9HhYx5zV/5eV4N47iQN5qLbHm+yjucAKvX8VD7c4qXFXmf0+sFyW+
         AYDz++P2JA2m7ZjTHHL8hCtsWprpP3/LE++K4NU3RTsJvNgy8frTZrxaFDl+36PNGJJE
         tnug==
X-Received: by 10.112.157.226 with SMTP id wp2mr2045286lbb.65.1370642786010;
 Fri, 07 Jun 2013 15:06:26 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 15:06:25 -0700 (PDT)
In-Reply-To: <1370642587-32352-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226749>

On Fri, Jun 7, 2013 at 5:03 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> -all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
> +all:: $(ALL_PROGRAMS) $(SCRIPTS_GEN) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS

Alternatively, we could add $(NO_INSTALL) here.

-- 
Felipe Contreras
