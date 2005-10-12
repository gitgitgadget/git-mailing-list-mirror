From: Morten Welinder <mwelinder@gmail.com>
Subject: diff_tree_stdin
Date: Tue, 11 Oct 2005 21:46:38 -0400
Message-ID: <118833cc0510111846q42c5d7e5j162bdacd49dfebbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 12 23:52:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPoVW-00067l-Dg
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 23:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVJLVv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 17:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVJLVv0
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 17:51:26 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:5194 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932432AbVJLVvZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 17:51:25 -0400
Received: by qproxy.gmail.com with SMTP id f11so135633qba
        for <git@vger.kernel.org>; Wed, 12 Oct 2005 14:51:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jfKoEjlgRxyphrdCLf2cXfznhLG9DhN9uq1N8gNwJuSJX0xnqUs76KXJsVc5aKay/rMhjWwwgnhE7vJqlOyE4UiJz9LCeUfvSnaVNer+SfDCUh32G7Tj9STApYakxUhYB0DRg8IRYoy5BeT0TKHTYiCOAVwsRBMhqetoGlmFy/Q=
Received: by 10.65.53.11 with SMTP id f11mr30117qbk;
        Tue, 11 Oct 2005 18:46:39 -0700 (PDT)
Received: by 10.65.107.8 with HTTP; Tue, 11 Oct 2005 18:46:38 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10053>

It looks like diff_tree_stdin can overrun the this_header buffer.  Since the
line length is already calculated, a check would be cheap.

Morten
