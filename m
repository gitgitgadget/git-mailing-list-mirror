From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] http*: cleanup slot->local after fclose
Date: Tue, 2 Jun 2009 21:55:23 +0800
Message-ID: <be6fef0d0906020655w64fa7653t908347b3dfc98f7b@mail.gmail.com>
References: <49F1EA6D.8080406@gmail.com> <20090530093717.GA22129@localhost>
	 <be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
	 <20090530230153.527532b0.rctay89@gmail.com>
	 <20090531000955.953725d9.rctay89@gmail.com>
	 <7vy6sdssnk.fsf@alter.siamese.dyndns.org>
	 <20090531175413.962a55c3.rctay89@gmail.com>
	 <7vws7xqazi.fsf@alter.siamese.dyndns.org>
	 <be6fef0d0906010652v4fc814f9j631795cbad61be9@mail.gmail.com>
	 <7vws7wkk4j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBUSo-0002PG-Sn
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 15:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbZFBNzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 09:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbZFBNzW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 09:55:22 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:59608 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZFBNzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 09:55:22 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2820460wfd.4
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IlZNEEv2Ln3AILiigOX7L1wvSKqilO50JvjV7RJ70m0=;
        b=lEVbD1IwzRmczFvb2csbm03DHm1FJRNDAwUfkuakBKXA4fXduci6XSjRVC3kIBnpkb
         fQfRwJm20Iz/+9pjYL9rxwTYhnKt57oVgEcpYGEQjMwuGNlDaIUP4WBH0PkL7/DjhSn1
         tmkpOTnL6DssYW2ey5AuL1kC346oEzj7aT4vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FqAxk3sFJYh0scZVjLrPxGHopGlMsZRmjIO5/w0TwcBI0qJEyAAliWe9+mW3gbnZxp
         o3ZKZZoTxZL8vMDDnuyED3diGDqQuRj+Clh4qTnPn3q2UkoE9tRdLNyfEB0rmqmS67Pp
         6WzOvsph/N2L0t13KOLOEQcuVUGJSWzgi8O+o=
Received: by 10.142.144.9 with SMTP id r9mr3069658wfd.91.1243950923786; Tue, 
	02 Jun 2009 06:55:23 -0700 (PDT)
In-Reply-To: <7vws7wkk4j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120510>

Hi,

On Tue, Jun 2, 2009 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I wish the commit log message explained that from the beginning without
> being asked.

Indeed, I guess I only hinted at the bug being fixed, and in the last
line, at that.

> So what would we want to do?

You can go ahead and apply this patch, many thanks. Don't bother with
re-applying the rc/http-push though; I'll send in the revised patches
sometime this weekend.

-- 
Cheers,
Ray Chuan
