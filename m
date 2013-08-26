From: Gordon Fontenot <gordon@thoughtbot.com>
Subject: Alias compdef between 1.8.0 and 1.8.3
Date: Mon, 26 Aug 2013 17:18:15 -0400
Message-ID: <20130826211815.GA78587@Gordons-MacBook-Pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 26 23:18:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE4Av-0007cC-Fv
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 23:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab3HZVSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Aug 2013 17:18:08 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:41823 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab3HZVSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 17:18:07 -0400
Received: by mail-qc0-f169.google.com with SMTP id k8so955374qcq.14
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 14:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=VLNFKBvPbAiOwWghWAqe54Ig3AB22pP3WXCz3LCOtSo=;
        b=WnfjPFqzU1EiWFN+DLggdf56ozUpoPpLP9YcOMPnu1CZmMVUNuPzmUUJxDWSHHRK8x
         NKJFDhYX89lewyMPBGOOK4CL8dEAITfvW3MDRmSeXYfnnAIv4if/C54wZrE9rMlMLQDU
         FWWzsSvGNcDxBD+jYgoHRSVySQXWaz3yqM/FvDJAZUCQh4VNt+0PAqImfNqTQ1yZd/Lm
         eBomwIF/0KHxTrL6JB5DUEAAg054jZz+61KBunmsNZcpVBUKX1FffpAWschug0E9twC0
         RUVU4USmjt5wxp9N2yoOn4SeIDrwynBpIhr0yE9r1NTzspFnqLRlGbAKquMF2rD4juWS
         SB/g==
X-Gm-Message-State: ALoCoQnOBPivw/aNDtWMwkmAWu9e6QvT6mKStpDCpjHLR7G89X7jDkn6qGThdg7ofNqjUOOWcemw
X-Received: by 10.49.96.68 with SMTP id dq4mr3736911qeb.92.1377551885566;
        Mon, 26 Aug 2013 14:18:05 -0700 (PDT)
Received: from localhost ([66.228.83.116])
        by mx.google.com with ESMTPSA id i10sm23087179qev.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 14:18:04 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233032>

Hello all,

As of 1.8.0, the compdefs I set up for my shell aliases (in zsh 5.0)
worked. They can be found here:
https://github.com/gfontenot/dotfiles/blob/master/git/completion.zsh

However, once updating to 1.8.3, they broke, complaining that zsh
couldn't find the command __git-checkout_main (for example). Is there
something special that I should be doing to get these completions to
work again?

Thanks,
 - Gordon

--=20
Gordon Fontenot
iOS developer at=A0thoughtbot
http://www.thoughtbot.com
@gfontenot
