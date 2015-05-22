From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Fri, 22 May 2015 13:05:28 -0700
Message-ID: <xmqqr3q8e5tj.fsf@gitster.dls.corp.google.com>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
	<1432112843-973-2-git-send-email-davvid@gmail.com>
	<20150520130929.Horde.vYwOuIDRpi6hr15rOUbW1w7@webmail.informatik.kit.edu>
	<20150522195802.GA26066@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 22:05:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvtCK-0004vj-8S
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 22:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbbEVUFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2015 16:05:32 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33570 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030215AbbEVUFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 16:05:31 -0400
Received: by igbpi8 with SMTP id pi8so9409igb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=ZVNZWM97gBbXmZcbviZWsjlH+mlIpSqIVulKGamIU/g=;
        b=xfpbHMq8wDUGjNN57jrACE361tTX4g1DHiFakybb/olBj7Uwmj/P2wY/9IVEUku808
         b2zZ7Zz0l6yoUbzbDdG1t2czD4ZOb0jqVXUeRNVZ5u3L/qRoVnCOx+rdcbUA0sKwa4gh
         7EfHfvGd8dA8iJXqp9+H+tuNVuxiyeeYQrWFOwQme+MLl3h8xLjnQ14zOgp5fGlM1BQN
         9BXeHxiwezGo6DlOEu20j1Qxhf0BOCZbfqiEU5SwdJvjDN9dMDzg5ITCQf9ZmFa1Olyk
         EWoZphnagvLtwo+3vwls1/XWTG9eQSVGIG2PmgTosfnU3OEwoqo7uh7VjFh0K4cKbz/P
         SD3Q==
X-Received: by 10.50.43.194 with SMTP id y2mr1826903igl.35.1432325130703;
        Fri, 22 May 2015 13:05:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id i185sm2517474ioi.24.2015.05.22.13.05.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 13:05:29 -0700 (PDT)
In-Reply-To: <20150522195802.GA26066@gmail.com> (David Aguilar's message of
	"Fri, 22 May 2015 12:58:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269758>

David Aguilar <davvid@gmail.com> writes:

> [just wrapping up the unaswered questions in this thread]
> ...
> On Wed, May 20, 2015 at 01:09:29PM +0200, SZEDER G=C3=A1bor wrote:

Thanks for clarifications.  I think all is good now?
