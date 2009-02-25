From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [tig PATCH v2 0/2] popup menu
Date: Wed, 25 Feb 2009 23:56:27 +0100
Message-ID: <cb7bb73a0902251456g70bf4a01ica17ecb37de20733@mail.gmail.com>
References: <1235311778-11112-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <2c6b72b30902251432p18f7cb48sb5565cc200d5e3b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 23:58:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcShT-0005MQ-7u
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 23:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758526AbZBYW4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 17:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758317AbZBYW4b
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 17:56:31 -0500
Received: from mail-ew0-f177.google.com ([209.85.219.177]:47893 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757811AbZBYW4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 17:56:30 -0500
Received: by ewy25 with SMTP id 25so391696ewy.37
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 14:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=05LUeuW4EvuXMLKGCHWuh/EiILCyk6m0fP941mOoSGw=;
        b=PgTJ9DX7188O5cOWICXUL8vRC/lDiiLnQyAHxKhZzeI2uCM6leNgNla6IZf+QhRg7p
         XmBFyajp7sVbl7pvKx7GgfOhKpGBGPL0UkkjWCRhGgQvB/VoNXE+bvzOKKcDvkcTukxd
         Tp51pc0Wo+SZURRMQsItAR3NSnQzsdc0e5P1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TXN5fAw910tzdWwT3R6Um6WjUW/9Ui8Pjua98Fd0DDPcd3WwmhfkaDrA2S1RBwQQBx
         HTpXHTNMeF1nmAA0EWoZ+gN9+JkNiqXLLTTz9ls7dO+hp8C7lZmSQp7pfNCw7US0uFtc
         uVoZslyMDMUvNyVPW6/LhSdu7lHJsikPBNEwo=
Received: by 10.210.54.19 with SMTP id c19mr340676eba.43.1235602587240; Wed, 
	25 Feb 2009 14:56:27 -0800 (PST)
In-Reply-To: <2c6b72b30902251432p18f7cb48sb5565cc200d5e3b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111508>

On Wed, Feb 25, 2009 at 11:32 PM, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Sun, Feb 22, 2009 at 15:09, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> Second version, in two patches. The first one is just the same as
>> previous one, minus a couple of leftovers.
>>
>> The second one reimplements the menu drawing routine so that it can be
>> called when necessary to redraw the menu entirely, e.g. after a resize
>> or when background loading finishes.
>
> I didn't read them through very carefully yet, so will "queue" them
> for now until I get fully back to tig. There are still some quirks
> that might needs to be addressed related with resizing, but this could
> also be fixed later. Anyway, I would like to think a bit more whether
> or not I like the cute menus, and also whether options might be served
> better by introducing an option view.

I like the minimalistic interface of tig, but when the user has to
select among a fixed number of choices it's much better to be able to
see all of them. The idea of a menu view which is not a popup is
probably good too, but it might have issues with the switching (what
if q is a hotkey? how would you close the view?)

> Regarding the "tig branch", would you mind if I postpone applying it
> until the branch view develops into something that is actually usable?

Please, be my guest 8-) I'm not even convinced it's useful anymore 8-)
("tig branch", not the branch view).

-- 
Giuseppe "Oblomov" Bilotta
