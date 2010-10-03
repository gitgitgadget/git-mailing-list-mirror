From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] Introduce the git fast-import-helper
Date: Sun, 3 Oct 2010 10:31:44 -0500
Message-ID: <20101003153144.GA18001@burratino>
References: <4CA86A12.6080905@dbservice.com>
 <1286108511-55876-5-git-send-email-tom@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 17:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Qau-0007a9-P4
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 17:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab0JCPfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 11:35:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54608 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab0JCPfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 11:35:07 -0400
Received: by iwn5 with SMTP id 5so5855148iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nqJNPBDkuURmZ3QwJsN2B0iHG42JfI+qZUKarrJtR4A=;
        b=u3wEiwTqTZjSfk5TN8K96OYbwF0eQQ+OflhISgrcqcTir5VW48tfJLmnzgOEYITPEj
         3Xj1Xa7x4Ab71a+VurFrXbT1irxyu+YWgF4e4lc9FREndb3QceM9yrTzFFUglLIWnyT9
         zdE37ZcxAlc4TjaQ+gYL7yqN1BzgC01TuNNGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z8cXWJhjaz8CxQndAeJcQkBxGmAfJDsgiJ71BmXU20AGlQAOXSOLYLoAct61eWLzP8
         /5CfX3jkCTJeRgo6avH72FcaNyUAVT0S6PjqAaXnCRQoVxDYrShwTnG+ug4V3C5PdBCV
         aepRJ85xxs9pXwNloalEZDzDLeTQq6P8PdXNc=
Received: by 10.231.14.140 with SMTP id g12mr8554183iba.84.1286120106518;
        Sun, 03 Oct 2010 08:35:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g31sm3816332ibh.16.2010.10.03.08.35.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 08:35:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286108511-55876-5-git-send-email-tom@dbservice.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157882>

Tomas Carnecky wrote:

>  fast-import-helper.c | 2201 ++++++++++++++++++++++++++++++++++++++++++++++++++

Aaa!  Could someone send a diff of this against the usual fast-import.c?

I'm sure you won't be surprised to hear I am not optimistic about the
long-term maintainability of two separate fast-import implementations.
If we get usability improvements by patching the existing fast-import,
that would be much better.
