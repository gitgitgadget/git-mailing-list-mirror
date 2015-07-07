From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 3/4] status: give more information during rebase -i
Date: Tue, 07 Jul 2015 15:14:17 -0700
Message-ID: <xmqqlher1upy.fsf@gitster.dls.corp.google.com>
References: <vpqk2ujoadw.fsf@anie.imag.fr>
	<1435784916-15456-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435784916-15456-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 08 00:14:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCb8C-0002aS-TD
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230AbbGGWOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 18:14:21 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37997 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932886AbbGGWOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 18:14:20 -0400
Received: by igrv9 with SMTP id v9so152537380igr.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=FYHmU5CtSFwA/kly0B59jUCRgXBQkuWGqgy6WcurgnM=;
        b=Nvwc2MxYAcJckGYstLAIkqp4u4BQ6s6vuO3bqPn8uekhYIrCYOo34qH2U9nJ0YzuGV
         PAgbhU3dQKPla90qN6q0yJKBXmSBFtGswYKxBZCBOereB49jjzZV7QcKKR6tMrDZ5DZe
         Rk7MP5orfokmVrR7ENA6sUuRJxe14zDx6/igTeEvWSvVt0pLyMZP26G1O71mNSgfUuvR
         OH1ZDySELNLC1e7fNXq6xzRePkC1iY6A5YEpKA+og6zcVSqTITIO+co4z5rK2fFXYo8I
         ZRDjcesOGTwErHfdlh0Vc4Uj8uaS1+HAA/S+avONeYmBfAdaNmve3h2hvRhf/4yOaNxU
         l++Q==
X-Received: by 10.107.12.18 with SMTP id w18mr7211783ioi.10.1436307259656;
        Tue, 07 Jul 2015 15:14:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id k16sm12741365igf.19.2015.07.07.15.14.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 15:14:18 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273610>

By the way, does this have any potential interaction with 16cf51c7
(git-rebase--interactive.sh: add config option for custom
instruction format, 2015-06-13)?  I _think_ that the other topic
should only affect the collapsed format, so there hopefully
shouldn't be a problem, but just double checking if you folks
considered the ramifications already.

Thanks.
