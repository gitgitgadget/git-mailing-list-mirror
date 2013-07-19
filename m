From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 21:12:02 +0530
Message-ID: <CALkWK0m-q=Aoof62zhXnUYsJ7PQZwTLbQ50BUEmufVO4gtWNUA@mail.gmail.com>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
 <7vr4euy4c6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 17:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0CpU-0004rY-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 17:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760833Ab3GSPmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 11:42:44 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45061 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760774Ab3GSPmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 11:42:43 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so9896645ieb.10
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D6mfV8alHbTDET/g8xWQA9lyDidYk/VOyZlJvkgqB2o=;
        b=zwlgdKLE/nTcDW9ou9hSMUmLhPX9yGjz/yXlXvlsJOIkV5Gh7L1qJtRNloYAcfXKHo
         BDUxsz0ebPJb1LI3FMMgg7V0nFkm8GjbrYOY1RD11yNMu8nC5VCVzY4pNpFWyWy/ECo1
         ryodgg/4zt2zTlJJ6Bxvj/24N2nKj/B92ic3o8DbqQ8KRVDzm/MHb661VhnYQ6jdk6QG
         YcPh0jD8Rrzw4SVQDx+IlB3smkYGCAwzThprm7YiKTbVwKzbhHAJHcNSzSpOmu0QggbR
         H7fHRHrl5lw+gSU9tPQ+Zb4ef9bCda/ZWxj7WsBjqRRaEJyD4bsIU/RhsbZk8TIfhooi
         88DQ==
X-Received: by 10.43.145.69 with SMTP id jt5mr11044693icc.65.1374248563063;
 Fri, 19 Jul 2013 08:42:43 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 08:42:02 -0700 (PDT)
In-Reply-To: <7vr4euy4c6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230817>

Junio C Hamano wrote:
> Did you know that the general way to spell the branch previously you
> were on is "@{-1}" and "checkout -" is an ugly special case that is
> possible only because "checkout" does not happen to take a "-" as a
> valid argument that means something else (like the more usual "read
> from standard input")?

I disagree that it is ugly: it's a very commonly used shortcut that I
like.  I love it so much that I have the following in my ~/.zshrc:

function - () {
	if test "true" = "$(g rp --is-inside-work-tree 2>/dev/null)"; then
		g co -
	else
		cd - >/dev/null
	fi
}

So, I just

  $ -

to switch back and forth :)
