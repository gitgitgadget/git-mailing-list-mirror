From: David Turner <dturner@twopensource.com>
Subject: [PATCH v13 0/3] git cat-file --follow-symlinks
Date: Wed, 20 May 2015 13:03:37 -0400
Message-ID: <1432141420-1027-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 19:04:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7Pf-0000Z8-Ae
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbbETREH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:04:07 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35440 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbbETREG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:04:06 -0400
Received: by iesa3 with SMTP id a3so44198967ies.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 10:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=459iX+yw5kNa3dFvUjIXcxMZlTlWMYJH6IC9SK48oDk=;
        b=lX0YD6LezdOvwS31kuferJSGHnXexwPIbP/8fyIT90mzhblILgNk8UYWjV7lowdGeE
         wAhZ4g0iEvBKX1/ZLVU4hphwafgCo0cPh6qBeHj9KmJOtkputGyI3WU4ujR9RhNg56qs
         Mkc4+dXCPX/5JObE8Nicv8qfhj3THs3tgoagSnbzSQe1eJGblW7SBJSFL/b+meK+wB5X
         YiWp68bnFrtHiEvQ9toh0LK3r+3ylbi+Xo3r+b7S/Wp4c0sHIVy0tEkwpHT9EmWgrsv5
         ncRisA3u3Q346qxNXGXN7JhTLHad/9O2O56gVhjya8yr1keNxtCkXZ0iaZ/zUoGAaz6f
         fkpw==
X-Gm-Message-State: ALoCoQmZDRz38q1tgxNxPKvA2TOnOKe8Cp8csn42rb1QbWuAf864z38WQmIfUSCUy8ANkUvEZtX4
X-Received: by 10.50.62.148 with SMTP id y20mr29229315igr.17.1432141445363;
        Wed, 20 May 2015 10:04:05 -0700 (PDT)
Received: from ubuntu.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id r4sm1993464igh.9.2015.05.20.10.04.03
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 10:04:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269473>

This version of the patch squashes in Ramsay Jones's fixes for a
couple of warnings.  Thanks, Ramsay!
