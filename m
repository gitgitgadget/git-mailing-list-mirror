From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fast-import should not care about core.ignorecase
Date: Mon, 8 Dec 2014 17:31:38 -0800
Message-ID: <20141209013138.GU16345@google.com>
References: <20141209001211.GA13386@glandium.org>
 <54864B3D.6040503@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 02:31:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy9eX-0006Rd-3q
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 02:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbaLIBbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 20:31:43 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38333 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439AbaLIBbl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 20:31:41 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so5663949ier.27
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 17:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iTFVh655Dju6aZK16YecaUO8K9hogGhv5mAEGfafJwI=;
        b=uDRUg52oyKH01Yc/unLtOhd5gsADzwMRg/lhxGYf6dc+S4c4CRbSzMvRZXbqSsun6q
         CX68UprzC8X/SIanuCuT4FQ6f7mlTiisD/JJdNe8PmXTNFxegS1TYmtJ3LadaUKSkRNQ
         yuAEzliXh4+AajSZv+UYRtYiOq5Dt3SOYm+X9g8CtyAX9eU59Jh7fn6f+Ui2FqOPJqRc
         vgHJtEC77IFJ/eXZthf02VzFt4UWOQuKBaHAGDePkg3ToynM+WkK1w9n+/DbwZtx/jVh
         hZKJdLXihnXHPT/nj6gFSulht8tMytrUbWjYDD0XleLEeQkUUxH0jEx/eEgtrXGyjiOi
         KbYw==
X-Received: by 10.50.131.134 with SMTP id om6mr10634090igb.17.1418088700905;
        Mon, 08 Dec 2014 17:31:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41c9:2fc6:1317:4ac])
        by mx.google.com with ESMTPSA id ii3sm4694491igb.1.2014.12.08.17.31.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Dec 2014 17:31:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54864B3D.6040503@workspacewhiz.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261103>

Joshua Jensen wrote:

> I think it has been discussed before, but maybe Git needs a
> core.casefold in addition to core.ignorecase.)

Would it work for --casefold to be a commandline flag to fast-import,
instead of a global option affecting multiple Git commands?

Curious,
Jonathan
