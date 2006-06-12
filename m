From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: Thoughts on adding another hook to git
Date: Mon, 12 Jun 2006 21:06:11 +0200
Message-ID: <f36b08ee0606121206k62242354k13671f95da6b1418@mail.gmail.com>
References: <448DB201.5090208@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 21:06:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fprjr-0005xN-M3
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbWFLTGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbWFLTGN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:06:13 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:21067 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752178AbWFLTGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:06:12 -0400
Received: by py-out-1112.google.com with SMTP id x31so1780383pye
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 12:06:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ozENE4WVVxeRR6Ssb7qptK7+HOSQsTbjqweZ/rCn+6/TRXbYJ/jYtBOK+9Jviy5LQfjHo2VHzrGCJpMVSCgGCgUCrf2Qh1cBCPmrzUcex+wRErMLrfGyUSqYVaTcC5EDXrTDPlmXHg1GMfr94l1egetN0w+KYq5Gw4p9h6pSBTQ=
Received: by 10.35.69.11 with SMTP id w11mr4638015pyk;
        Mon, 12 Jun 2006 12:06:11 -0700 (PDT)
Received: by 10.35.14.20 with HTTP; Mon, 12 Jun 2006 12:06:11 -0700 (PDT)
To: "David Kowis" <dkowis@shlrm.org>
In-Reply-To: <448DB201.5090208@shlrm.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21727>

On 6/12/06, David Kowis <dkowis@shlrm.org> wrote:
> I'd like to be able to modify the commit message before it ends up in
> the $EDITOR.

Can't you define $EDITOR to point to some script
which modifies the file as you wish then calls the
real editor on it ?

Yakov
