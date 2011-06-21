From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Cooking --continue
Date: Tue, 21 Jun 2011 12:57:44 +0530
Message-ID: <BANLkTikDNjYgZpeitnKEhkPzVKqWaAT24A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 09:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYvNe-0003pS-AM
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 09:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab1FUH2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 03:28:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38791 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab1FUH2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 03:28:05 -0400
Received: by wyb38 with SMTP id 38so2176520wyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=P42zg2OoryjvyPfUcbNnE4dOWK1SGH0GClJiVk0Wop0=;
        b=q52WjBXchkaNop75+m69bnIM8acHklgOBRueNwRiSrNgKcfWo9tF3PSFMsqud+ea7S
         MHVNXAwgaR4gWnXWXCv+WtrumsfgWALYaGwlWSOab3fvgCAWhU1HPwXo5fxNRayqRi1k
         1y8PiLo/mqHu9RMIKkOZMGRXoUkExilI3toj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=tczqnTdZsFI7/d4OBe9XJoZidMmpxLlC1oUiiLggxo01ZVYlAhHG8WC6qh3bxGS+lm
         VLtEaSooT2KoxvQQ9HzYVbgNvpPxx+1QFl7gL25yqNnVw47cDf/TVnErrFZ7ZbYKkY04
         +9WmTqYE01hGqeZGL1fEXvxZvwFXXEa7ojOsE=
Received: by 10.216.61.1 with SMTP id v1mr2041224wec.61.1308641284085; Tue, 21
 Jun 2011 00:28:04 -0700 (PDT)
Received: by 10.216.18.16 with HTTP; Tue, 21 Jun 2011 00:27:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176130>

Hi,

Quick update.  I'm currently working on polishing the my series with
"--continue" implemented, before sending it off to the list for
inclusion.  There are only a few glitches [1], and I think I've got
most of it figured out.  The latest work can be found in the
'sequencer-continue' branch of my Github fork [2].

Thanks.

-- Ram

[1]: http://mid.gmane.org/1308636458-19668-1-git-send-email-artagnon@gmail.com
[2]: http://github.com/artagnon/git
