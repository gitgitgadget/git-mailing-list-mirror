From: "Miles Bader" <miles@gnu.org>
Subject: Re: [PATCH] Make git-archimport log entries more consistent
Date: Thu, 30 Aug 2007 12:19:00 +0900
Message-ID: <fc339e4a0708292019s3d4f6914h4f9efe6f1172c380@mail.gmail.com>
References: <617indss2f.fsf@fencepost.gnu.org>
	 <7vmyw9af3q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 05:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQaYl-00032p-Gc
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 05:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXH3DTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 23:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbXH3DTD
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 23:19:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:62259 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbXH3DTB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 23:19:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so384920wxd
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 20:19:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=s5z77yHM4L5WQ30FI75zeyetih+ReJLuuaqaFUbQD/L9I/jyZusHgtGLGkgfFwHzLbCVhXLd+iGPYmzF/IvL15PNbjgxp4P++qF/iqGu/Ez0TJwGx6LRw9StqGKxXOHnfBelec6SrDmJ795KS5Yc4kKj7ja2jAFyKcjQeEFZzEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ndgWLuKTQqfUWwXQi/0/6s3bH+xwKoysytWgISuejZo9ZXhZeoyzk+uVYeXyBuU954QPgIjrLeDhqs+B6CunHHDJINkXzDhGmlxiyvQCm89xz2YKOb1GFrtuWHUlydLt6LTA3uoRNMM8tkSCcqquTVYuczm37wAmrjFLS1z1CXY=
Received: by 10.90.68.15 with SMTP id q15mr12984aga.1188443940679;
        Wed, 29 Aug 2007 20:19:00 -0700 (PDT)
Received: by 10.90.105.17 with HTTP; Wed, 29 Aug 2007 20:19:00 -0700 (PDT)
In-Reply-To: <7vmyw9af3q.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 02d71185a2495cd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56996>

On 8/30/07, Junio C Hamano <gitster@pobox.com> wrote:
> > This patch makes git-archimport generate one blank line as a separator in all
> > cases.
>
> I would not have any problem with what the result of this patch
> would record in the commits, if it was what it did from the very
> beginning.  But this is a change in behaviour; I'd like to know
> if people who use archimport _rely_ on the current behaviour...

Good point, though it seems pretty unlikely -- the most notable thing
about the old behavior was that the results were inconsistent... :-)

-Miles

-- 
Do not taunt Happy Fun Ball.
