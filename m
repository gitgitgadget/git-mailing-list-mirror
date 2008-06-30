From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [RFC] Single system account for multiple git users
Date: Mon, 30 Jun 2008 21:05:02 +0400
Message-ID: <37fcd2780806301005w66500825n79719ce9950d807d@mail.gmail.com>
References: <20080630151113.GO5737@dpotapov.dyndns.org>
	 <m3iqvqhptu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDMpG-0000IJ-EL
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 19:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbYF3RFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 13:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYF3RFE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 13:05:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:55406 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbYF3RFD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 13:05:03 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1627703wfd.4
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wUUplgszhgInnbXJdwskvY9H08lqRbBiueGdjpGmBXQ=;
        b=CCQoQpfRlIiZTl3KeCisDKDSg6EMtVrYCgKa+If0TxS3lWOpunUNEsxjlNNdzyQuOl
         HEfUaBwiZmN1MRkD2ZzYIth6TFujFyoAHdjvxWmSuU9QWye82ZO7rbDIfnOCFFUTokzr
         qPOHKnpqhKGvD6lepAsiZqC98h+6GufXQf/TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KbM/zuVbBLYRM8tINfFJgACYNDwCL6HBwdgv0STG8Dg2NGHQVenlkqkjWERiOiI7RF
         Wq69sXellWrCHZYcb4/fdwWHUz+9Ydg/Q4nQs44sr9AZ/9gKbuw3GlEVEh0x50hP3dYT
         ijOHzlA0mrPNEHgDCJPBM+IXyD3Ncb9rzhSd8=
Received: by 10.142.229.5 with SMTP id b5mr1995211wfh.50.1214845502126;
        Mon, 30 Jun 2008 10:05:02 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Mon, 30 Jun 2008 10:05:02 -0700 (PDT)
In-Reply-To: <m3iqvqhptu.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86923>

On Mon, Jun 30, 2008 at 8:04 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> Have you took a look at ssh_acl from InterfacesFrontendsAndTools
> from Git Wiki?

I have looked at it and if I am not mistaken it requires the normal
shell as login shell.

BTW, the link to GitWiki is outdated, the new link is
http://www.inf.ufpr.br/ribas/ssh_acl.html
but it practically lacks of all documentation, and at the top
of that page, you can see:
===================
WARNING

These explanation are outdated!

I already wrote a new version and I'm using

Soon I will update here
===================

My goal was to have something small and simple. I really like git-shell
plus the update hook from the documentation, but that does not allow
to have multiple Git users with a single system account.

Dmitry
