From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded
 in the pack
Date: Sun, 30 Oct 2011 16:31:15 +0700
Message-ID: <CACsJy8A1QtHS2Y-O+NmO6MNDTcG_Wqc+Q1zk0RDGei=VTuxkPg@mail.gmail.com>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org> <7vwrbptzjm.fsf@alter.siamese.dyndns.org>
 <CACsJy8Cz0R_s+VYRd+1wTTfbt_vH5dd3ALgZip0xn7rfYf6gpw@mail.gmail.com> <7v4nyrrm1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 10:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKRov-0007vR-UL
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 10:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671Ab1J3Jbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 05:31:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36479 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481Ab1J3Jbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 05:31:47 -0400
Received: by bkbzt4 with SMTP id zt4so1413354bkb.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7xTCF+LShDrauMUESQaaslayGP6mTd34gB5Y6C3rqI4=;
        b=MHwWPRit9q+uP1/x4jE6RGS5PSCePQvG1LuVrsqpoQe5SxYdN8PQnaHQvZDqgtzt+2
         CLSukYCpwVoGw3epO89jIQlXD6elTcMX5dV+SvdWGgK6fiyW09OvjeQfBpF9xQMmqLA+
         AZZVceXoYly6IT2s8+e2XWPjUy6rGsoexI0JY=
Received: by 10.204.9.205 with SMTP id m13mr7189959bkm.32.1319967106284; Sun,
 30 Oct 2011 02:31:46 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Sun, 30 Oct 2011 02:31:15 -0700 (PDT)
In-Reply-To: <7v4nyrrm1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184470>

On Sun, Oct 30, 2011 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Not sure if it's related to representation types, but is there any way
>> (perhaps FLAT_BLOB type?) we can mark an object uncompressed, so we
>> can mmap() and access it directly?
>
> In pack? Loose? Both?
>
> What kind of payload and use case do you have in mind?

Hmm.. big files in general with partial file transfer (e.g. git
torrent). But if CAT_TREE is properly used, then all blob pieces
should be reasonably small and decompress time should not be a
problem. I think we won't need this. Sorry for the noise.
-- 
Duy
