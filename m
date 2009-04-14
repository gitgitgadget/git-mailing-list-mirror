From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 08/13] send-email: Remove superfluous `my $editor = 
	...'
Date: Mon, 13 Apr 2009 19:41:31 -0500
Message-ID: <b4087cc50904131741h70668a48ta52797722e9fdf38@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
	 <49E3CD48.1010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 02:43:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtWk0-0000tr-BW
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 02:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZDNAlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 20:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbZDNAlf
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 20:41:35 -0400
Received: from mail-qy0-f117.google.com ([209.85.221.117]:39748 "EHLO
	mail-qy0-f117.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbZDNAle (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 20:41:34 -0400
Received: by qyk15 with SMTP id 15so289810qyk.33
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 17:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nphGe6rEcVapkvv/v/UBPpRqvQwaP920fUtZlFvGATc=;
        b=bcr2lDto4YolY/kSGHUBBJ6B7/P12194HcJnBA9UlPEpuWnJCMhCpYct7JE/Fg3QKt
         sND+nAgYoucwP1NfT6NpWr65ZMrknK4lazJdnzTzh22LkZWJyL9gu9ZLA7/H5RjYzx6g
         o5LLMaka99Xc+Ab7mmiUny1V/F3GElpFLiimM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rcJv738XlfgSp8BQhgl6S+zebFFoDDIDvhzzsRhBhVKZ9iYG0dvMusZ11heyCcc3jN
         Xq5VpDWOVroE6HkIkwKQBN3edjQ6b67YrpEPTI20/3O80qnnsX+bpeWYNun86PD3RHDa
         r+NeV7ncUd2yeANJ8JhIUQmP089SwJY2XYNis=
Received: by 10.224.80.195 with SMTP id u3mr6798872qak.354.1239669691189; Mon, 
	13 Apr 2009 17:41:31 -0700 (PDT)
In-Reply-To: <49E3CD48.1010809@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116505>

On Mon, Apr 13, 2009 at 18:39, Stephen Boyd <bebarino@gmail.com> wrote:
> I don't want to start an editor war, but why is 'vi' here?

The program vi is on every single Unix installation. Take that as an axiom.
