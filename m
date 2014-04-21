From: Shawn Pearce <spearce@spearce.org>
Subject: Re: security vulnerability disclosure procedure?
Date: Mon, 21 Apr 2014 11:07:17 -0700
Message-ID: <CAJo=hJsU7hLMwkvPMqM7J7Tj0svQzQwp8xXHRKr=Gp8W6j55dA@mail.gmail.com>
References: <53543121.3000808@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 20:07:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcId5-0005tF-W0
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 20:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaDUSHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 14:07:40 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56449 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbaDUSHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 14:07:39 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so3915568wes.5
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6aaIx+tLHC4/nOZy5bXVzf/LUm/jAGZrjc1jgG4vKto=;
        b=Hb+2V9wc7czkw8cWLo/5E2GzEmF03KH2EGWVIshSJ3H/B20hYUkblX9CQjMQvjo2ME
         Mn8WbaChRwJAyxEZzc8YQ0GMTpWCZWefYKQ+fBV56x92f0bLdJerY1h49lsRdoobHHh0
         XbYxp7a4APjD0wnt9x+dQEXPigfcQlTVLXcGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6aaIx+tLHC4/nOZy5bXVzf/LUm/jAGZrjc1jgG4vKto=;
        b=Wc7OCht/JnTyCZXeNWjgJbmxJfT1s1mYeNajBjwsCoN2M7PU5k3KdDLPxv4XZ0wSYy
         /ZRphexqt6dnzfOnU929KSBC0rC4etBU54EbIlrj9Hp6nqN91EsvBIaB1RsmKMSj3LGp
         8+TCZKax71IYWZPAfnChiWjEBx7UkGmM2ex4K7m2tKMnK0JyCtpzVLRl4zxEFzPpx8Ls
         ptq0JQxKr5HAF1x3InQzMiXO0yX9y7p44jkkd0fElcHgYaAeghH0/BuL9X5hx4K8be3Y
         udlHXj0nDhhYfdL6P+ctfPtUBjh3Q/RwbmJcoE7nNPsEKr7kS9tEJZGVE3cKQLgGlwAU
         5cmQ==
X-Gm-Message-State: ALoCoQlLqo1zv6LkRHngZC2IvFMjXJUybK5dBQ41f2iM5D1yn3fJEXX/P1Ll7QiV12pootrGAnbg
X-Received: by 10.180.8.136 with SMTP id r8mr14891678wia.60.1398103657399;
 Mon, 21 Apr 2014 11:07:37 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Mon, 21 Apr 2014 11:07:17 -0700 (PDT)
In-Reply-To: <53543121.3000808@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246615>

On Sun, Apr 20, 2014 at 1:42 PM, Richard Hansen <rhansen@bbn.com> wrote:
> I have discovered a minor security vulnerability.  I could send the
> patch to the mailing list, but I wanted someone else to take a look
> first just to make sure it's minor enough that folks will think it's OK
> to publicly announce.
>
> Who should I send the patch to?

Previous issues were routed through the maintainer, Junio directly (CC'd).
